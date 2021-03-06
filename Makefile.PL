use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'Arkess',
  VERSION_FROM => 'lib/Arkess.pm',
  ABSTRACT => 'Tile-based RPG framework',
  AUTHOR => 'Bremen Braun <konapun.zero@gmail.com>',
  LICENSE => 'MIT',
  META_MERGE => {
    resources => {
      license => 'http://opensource.org/licenses/MIT',
      repository => 'https://github.com/konapun/arkess.git'
    },
    no_index => {
      directory => ['t']
    }
  },
  PREREQ_PM => {
    'Time::HiRes' => '1.9726',
    'Image::Size' => '3.232',
    'File::List' => '0.3.1',
    'SDL' => '2.544',
    'Image::ParseGIF' => '0.2',
    'Color::Rgb' => '1.4',
    'GD' => '2.56',
    'threads' => '1.96',
    'Curses' => '1.32', # need curses.h provided by libncurses5-dev on Ubuntu
    'Curses::UI' => '1.32',
    'Scalar::Util::Numeric' => '0.40',
    'State::Machine' => '0.07',
    'Digest::MD5' => '2.54'
  },
  EXE_FILES => {
    # TODO
  }
);
