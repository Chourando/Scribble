//  Scribble v4.0.0
//  2019/03/25
//  @jujuadams
//  With thanks to glitchroy and Rob van Saaze
//  
//  MSDF texture page generator by donmccurdy:
//  https://github.com/donmccurdy/msdf-bmfont-web
//  https://msdf-bmfont.donmccurdy.com/
//  
//  Intended for use with GMS2.2.1 and later

scribble_init_start( "Fonts", 2048 );
scribble_init_add_font( "fTestA" );
scribble_init_add_font( "fTestB" );
scribble_init_add_spritefont( "sSpriteFont", 3 );
scribble_init_add_font( "fChineseTest" );
scribble_init_end();

scribble_add_colour( "c_coquelicot", $ff3800 );
scribble_add_colour( "c_smaragdine", $50c875 );
scribble_add_colour( "c_xanadu"    , $738678 );
scribble_add_colour( "c_amaranth"  , $e52b50 );

instance_destroy();
room_goto_next();