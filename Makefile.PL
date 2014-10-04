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
    'IOC' => '0.29',
    'Time::HiRes' => '1.9726',
    'Image::Size' => '3.232',
    'SDL' => '2.544'
  },
  EXE_FILES => {
    # TODO
  }
);
