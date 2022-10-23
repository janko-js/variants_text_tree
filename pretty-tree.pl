#!/usr/bin/perl
use JSON;

my $fn =
    "data.json";
    #$ARGV[0];

my $ALIAS = 'compressed_name';
my $NAME = 'name';
my $CHILDREN = 'children';

open( $f, $fn );
my $s;
{
    $/ = undef;
    $s = <$f>
}

my $r = decode_json( "[$s]" );
print_children_grouped( $r, 0, 1 );


sub print_name_alias {
    my ( $r, $same_line ) = @_;
    if (   exists( $r->{$ALIAS} )
        && $r->{$NAME} ne $r->{$ALIAS}
    ) {
        # print '"name": "',$r->{$NAME}, '", "alias": ', $r->{$ALIAS}, "\" ";
        print '',$r->{$NAME}, ' (', $r->{$ALIAS}, "), ";
    } else {
        # print '"name": "',$r->{$NAME}, "\", ";
        print '',$r->{$NAME}, ", ";
    }
    print "\n" if ( !$same_line );
}

sub get_this_name
{
    my ( $r ) = @_;
    return $r->{$NAME};
}

sub childless
{
    my ( $r ) = @_;
    my $children = $r->{$CHILDREN};
    my $is_childless = !defined( $children ) || scalar( @$children ) == 0;
    # print "childless ", $is_childless, "\n";
    return $is_childless;
}

sub get_end_num
{
    my ( $s ) = @_;
    if ( $s =~ /(\d+)$/ ) {
        return int( $1 );
    }
    return 0;
}

sub is_not_sequential
{
    my ( $curr, $prev ) = @_;
    my $end_curr = get_end_num( $curr );
    my $end_prev = get_end_num( $prev );
    return ( $end_curr != $end_prev + 1 );
}

sub print_children_grouped
{
    my ( $ra ) = @_;
    my $i = 0;
    for (;;) {
        my $prev_name = get_this_name( $ra->[$i] );
        # print  "prev name start: $prev_name\n";
        my $p = $i + 1;
        if ( childless( $ra->[$i] ) ) {
            for (;;) {
                last if ( $p >= scalar( @$ra ) );
                my $curr_name = get_this_name( $ra->[$p] );
                # print  "curr name $curr_name\n";
                last if ( is_not_sequential( $curr_name, $prev_name ) );
                last if ( !childless( $ra->[$p] ) );
                $prev_name = $curr_name;
                # print  "prev name $prev_name\n";
                $p++;
            }
        }
        print_childless_group_or_one_with( $ra, $i, $p );
        $i = $p;
        if ( $i >= scalar( @$ra ) ) {
            last;
        }
    }
}


sub print_childless_group_or_one_with
{
    my ( $ra, $i, $p ) = @_;
    # print( "$i $p\n" );
    my $ra_ra = $ra->[$i]->{$CHILDREN};
    if ( defined( $ra_ra ) && scalar( @$ra_ra ) ) {
        print_name_alias( $ra->[$i], 0 );
        print "[ ";
        print_children_grouped( $ra_ra );
        print "]\n";
    } else {
        while ( $i < $p ) {
            print_name_alias( $ra->[$i], 1 );
            $i++;
        }
    }
    print "\n";
}
