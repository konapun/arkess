use SDLx::Sprite::Animated;

  # simplest possible form, where 'hero.png' is an image containing
  # fixed-length sprites in sequence. It doesn't matter if they are
  # placed vertically or horizontally, as long as the the widest
  # side is a multiple of the (narrowest) other. The widget will
  # automatically divide it in the proper frames, provided there is
  # no slack space between each frame.

  my $animation = SDLx::Sprite::Animated->new(image => 'assets/characters/ryu-sprite.png');

  # that's it! Defaults are sane enough to DWIM in simple cases,
  # so you just have to call draw() on the right place. If you
  # need to setup your animation or have more control over it,
  # feel free to use the attributes and methods below.

  # these are the most useful methods to use in your game loop
  # (or wherever you want to manipulate the animation):
  $animation->next;
  $animation->previous;
  $animation->reset;

  $animation->current_frame;   # current frame number
  $animation->current_loop;    # current loop number

  # you can control positioning just like a regular SDLx::Sprite:
  #$animation->rect;
  #$animation->x;
  #$animation->y;

  # just like a regular Sprite, we fetch our source rect from ->clip,
  # updating it on each call to ->next (or ->previous, or ->reset).
  # If source rects for your animation are further appart (or less)
  # than the rect's width and height, you can adjust the animation
  # x/y offsets:
  $animation->step_x(15);
  $animation->step_y(30);

  $animation->draw($screen); # remember to do this! :)

  # we can also call ->next() automatically after each draw():
  $animation->start;
  $animation->stop;

  # default is to go to the next frame at each draw(). If this is
  # too fast for you, change the attribute below:
  $animation->ticks_per_frame(10);

  # select type of animation loop when it reaches the last frame:
  $animation->type('circular'); # restarts loop at the beginning
  $animation->type('reverse');  # goes backwards

  $animation->max_loops(3); # 0 or undef for infinite looping
