 use SDLx::Sprite;

    my $sprite = SDLx::Sprite->new(image => 'assets/characters/ryu-sprite.png');

    # set sprite image transparency
#    $sprite->alpha_key( $color );
#    $sprite->alpha(0.5);

    # you can set and check the sprite position anytime
    print $sprite->x . "\n";   # rect->x shortcut accessor
    $sprite->y(30);   # rect->y shortcut accessor

    # read-only surface dimensions
    $sprite->w;   # width
    $sprite->h;   # height

    # you can also fetch the full rect
    # (think destination coordinates for ->draw)
    my $rect = $sprite->rect;

    # you can get the surface object too if you need it
    my $surface = $sprite->surface;

    # rotation()

    # if your SDL has gfx, rotation is also straightforward:
    $sprite->rotation( $degrees );
    $sprite->rotation( $degrees, $smooth );


    # add() / remove() NOT YET IMPLEMENTED
    # you can also attach other sprites to it
#    $sprite->add( armor => $other_sprite );
#    $sprite->remove('armor');

    # blits $sprite (and attached sprites) into $screen,
    # in the (x,y) coordinates of the sprite
#    $sprite->draw($screen);
