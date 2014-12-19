use SDL;
use SDL::Video;
use SDL::Surface;
use SDL::Rect;

# the size of the window box or the screen resolution if fullscreen
my $screen_width = 800;
my $screen_height = 600;

SDL::init(SDL_INIT_VIDEO);

# setting video mode
my $screen_surface = SDL::Video::set_video_mode($screen_width, $screen_height, 32, SDL_ANYFORMAT);

# drawing a rectangle with the blue color
my $mapped_color = SDL::Video::map_RGB($screen_surface->format(), 0, 0, 255);
SDL::Video::fill_rect($screen_surface, SDL::Rect->new(
  $screen_width / 4,
  $screen_height / 4,
  $screen_width / 2,
  $screen_height / 2), $mapped_color);

# update an area on the screen so it's visible
SDL::Video::update_rect($screen_surface, 0, 0,
$screen_width, $screen_height);

sleep(5);
