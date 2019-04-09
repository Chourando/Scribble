//  Scribble v4.4.1
//  2019/04/02
//  @jujuadams
//  With thanks to glitchroy and Rob van Saaze
//  
//  
//  Intended for use with GMS2.2.1 and later

//Basic input and draw settings
#macro SCRIBBLE_DEFAULT_SPRITEFONT_MAPSTRING  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,.-;:_+-*/\\'\"!?~^°<>|(){[]}%&=#@$ÄÖÜäöüß"
#macro SCRIBBLE_HASH_NEWLINE                  true  //Replaces hashes (#) with newlines (ASCII chr10) to emulate GMS1 behaviour
#macro SCRIBBLE_COLOURISE_SPRITES             true  //Whether to apply the text colour to non-animated sprites (animated sprites are always blended white)

//Default draw settings
#macro SCRIBBLE_DEFAULT_XSCALE             1                   //The default x-scale of the textbox
#macro SCRIBBLE_DEFAULT_YSCALE             1                   //The default y-scale of the textbox
#macro SCRIBBLE_DEFAULT_BOX_HALIGN         fa_left             //The default alignment of the textbox. fa_left places the left-hand side of the box at the draw coordinate when using scribble_draw()
#macro SCRIBBLE_DEFAULT_BOX_VALIGN         fa_top              //The default alignment of the textbox. fa_top places the top of the box at the draw coordinate when using scribble_draw()
#macro SCRIBBLE_DEFAULT_ANGLE              0                   //The default rotation of the textbox
#macro SCRIBBLE_DEFAULT_STEP_SIZE          (delta_time/16667)  //The default step size. "(delta_time/16667)" assumes that the game is running at 60FPS and will delta time effects accordingly
#macro SCRIBBLE_DEFAULT_SPRITE_SPEED       0.1                 //The default animation speed for sprites inserted into text
#macro SCRIBBLE_DEFAULT_PREMULTIPLY_ALPHA  false               //Whether or not to premultiply alpha by default

//Default animation settings
#macro SCRIBBLE_DEFAULT_WAVE_SIZE          4     //The default magnitude of the text wave animation. A value of "4" will cause the wave to extend 4 pixels above and 4 pixels below the line of text
#macro SCRIBBLE_DEFAULT_WAVE_FREQUENCY    50     //The default frequency of the text wave animation. Higher values cause the wave peaks to be closer together
#macro SCRIBBLE_DEFAULT_WAVE_SPEED         0.2   //The default speed of the text wave animation
#macro SCRIBBLE_DEFAULT_SHAKE_SIZE         4     //The default magnitude of the text shake animation. A value of "4" will cause the shake to extend 4 pixels along each axis
#macro SCRIBBLE_DEFAULT_SHAKE_SPEED        0.4   //The default speed of the text shake animation
#macro SCRIBBLE_DEFAULT_RAINBOW_WEIGHT     0.5   //The default blend weight of the rainbow effect. A value of "0.5" will equally blend the text's original colour with the rainbow colour
#macro SCRIBBLE_DEFAULT_RAINBOW_SPEED      0.01  //The default speed of the rainbow effect

//Typewriter effect settings
#macro SCRIBBLE_DEFAULT_TYPEWRITER_SPEED       0.3                                //The default speed of the typewriter effect, in characters/lines per frame
#macro SCRIBBLE_DEFAULT_TYPEWRITER_SMOOTHNESS  3                                  //The default smoothhness of the typewriter effect. A value of "0" disables smooth fading
#macro SCRIBBLE_DEFAULT_TYPEWRITER_METHOD      SCRIBBLE_TYPEWRITER_PER_CHARACTER  //The default typewriter effect method
//Use these contants for scribble_typewriter_in() and scribble_typewrite_out():
#macro SCRIBBLE_TYPEWRITER_WHOLE               0                                  //Fade the entire textbox in and out
#macro SCRIBBLE_TYPEWRITER_PER_CHARACTER       1                                  //Fade each character individually
#macro SCRIBBLE_TYPEWRITER_PER_LINE            2                                  //Fade each line of text as a group

//Miscellaneous advanced settings
#macro SCRIBBLE_COMPATIBILITY_DRAW                 false    //Forces Scribble functions to use GM's native draw_text() renderer. Turn this on if certain platforms are causing problems
#macro SCRIBBLE_FORCE_NO_SPRITE_ANIMATION          false    //Forces all sprite animations off. This can be useful for testing rendering without the Scribble shader set
#macro SCRIBBLE_CALL_STEP_IN_DRAW                  false    //Calls scribble_step() at the start of scribble_draw() for convenience. This isn't recommended - you should keep logic and drawing separate where possible in your code!
#macro SCRIBBLE_EMULATE_LEGACY_SPRITEFONT_SPACING  true     //GMS2.2.1 made spritefonts much more spaced out for some reason. Turn this if you want to replicate pre-GMS2.2.1 spritefont behaviour
#macro SCRIBBLE_FIX_NEWLINES                       true     //The newline fix stops unexpected newline types from breaking the parser, but it can be a bit slow
#macro SCRIBBLE_SLANT_AMOUNT                       4        //The x-axis displacement when using the [slant] tag
#macro SCRIBBLE_Z                                  0        //The z-value for vertexes

//scribble_get_box() constants
enum SCRIBBLE_BOX
{
    X0, Y0, //Top left corner
    X1, Y1, //Top right corner
    X2, Y2, //Bottom left corner
    X3, Y3  //Bottom right corner
}

//scribble_set_glyph_property() and scribble_get_glyph_property() constants
//You'll usually only want to modify SCRIBBLE_GLYPH.X_OFFSET, SCRIBBLE_GLYPH.Y_OFFSET, and SCRIBBLE_GLYPH.SEPARATION
enum SCRIBBLE_GLYPH
{
    CHARACTER,  // 0
    INDEX,      // 1
    WIDTH,      // 2
    HEIGHT,     // 3
    X_OFFSET,   // 4
    Y_OFFSET,   // 5
    SEPARATION, // 6
    U0,         // 7
    V0,         // 8
    U1,         // 9
    V1,         //10
    __SIZE      //11
}

//Sequential glyph indexing settings
//Normally, Scribble will try to sequentially store glyph data in an array for fast lookup.
//However, some font definitons may have disjointed character indexes (e.g. Chinese). Scribble will detect these fonts and use a ds_map instead for glyph data lookup
#macro SCRIBBLE_SEQUENTIAL_GLYPH_TRY               true
#macro SCRIBBLE_SEQUENTIAL_GLYPH_MAX_RANGE         200      //If the glyph range (min index to max index) exceeds this number, a font's glyphs will be indexed using a ds_map
#macro SCRIBBLE_SEQUENTIAL_GLYPH_MAX_HOLES         0.50     //Fraction (0 -> 1). If the number of holes exceeds this proportion, a font's glyphs will be indexed using a ds_map

//Command tag customisation
#macro SCRIBBLE_COMMAND_TAG_OPEN                   ord("[") //Character used to open a command tag. First 127 ASCII chars only
#macro SCRIBBLE_COMMAND_TAG_CLOSE                  ord("]") //Character used to close a command tag. First 127 ASCII chars only
#macro SCRIBBLE_COMMAND_TAG_ARGUMENT               ord(",") //Character used to delimit a command parameter inside a command tag. First 127 ASCII chars only

//Shader constants
//SCRIBBLE_MAX_FLAGS or SCRIBBLE_MAX_DATA_FIELDS must match the corresponding values in shader shScribble
#macro SCRIBBLE_MAX_FLAGS                          4  //The maximum number of flags. "Flags" are boolean values that can be set per character, and are sent into shScribble to trigger animation effects etc.
#macro SCRIBBLE_MAX_DATA_FIELDS                    7  //The maximum number of data fields. "Data fields" are misc 
#macro SCRIBBLE_DEFAULT_DATA_FIELDS                [SCRIBBLE_DEFAULT_WAVE_SIZE, SCRIBBLE_DEFAULT_WAVE_FREQUENCY, SCRIBBLE_DEFAULT_WAVE_SPEED, SCRIBBLE_DEFAULT_SHAKE_SIZE, SCRIBBLE_DEFAULT_SHAKE_SPEED, SCRIBBLE_DEFAULT_RAINBOW_WEIGHT, SCRIBBLE_DEFAULT_RAINBOW_SPEED]

#region -- Internal Definitions --

#macro __SCRIBBLE_VERSION  "4.4.1"
#macro __SCRIBBLE_DATE     "2019/04/02"
#macro __SCRIBBLE_DEBUG    false

enum __SCRIBBLE_FONT
{
    NAME,         // 0
    TYPE,         // 1
    GLYPHS_MAP,   // 2
    GLYPHS_ARRAY, // 3
    GLYPH_MIN,    // 4
    GLYPH_MAX,    // 5
    TEXTURE,      // 6
    SPACE_WIDTH,  // 7
    MAPSTRING,    // 8
    SEPARATION,   // 9
    __SIZE        //10
}

enum __SCRIBBLE_FONT_TYPE
{
    FONT,
    SPRITE
}

enum __SCRIBBLE_LINE
{
    X,          //0
    Y,          //1
    WIDTH,      //2
    HEIGHT,     //3
    LENGTH,     //4
    FIRST_CHAR, //5
    LAST_CHAR,  //6
    HALIGN,     //7
    WORDS,      //8
    __SIZE      //9
}

enum __SCRIBBLE_WORD
{
    X,              // 0
    Y,              // 1
    WIDTH,          // 2
    HEIGHT,         // 3
    SCALE,          // 4
    SLANT,          // 5
    VALIGN,         // 6
    STRING,         // 7
    INPUT_STRING,   // 8
    SPRITE,         // 9
    IMAGE,          //10
    IMAGE_SPEED,    //11
    LENGTH,         //12
    FONT,           //13
    COLOUR,         //14
    FLAGS,          //15
    NEXT_SEPARATOR, //16
    __SIZE          //17
}

enum __SCRIBBLE_VERTEX_BUFFER
{
    VERTEX_BUFFER,
    TEXTURE,
    __SIZE
}

enum __SCRIBBLE
{
    __SECTION0,          // 0
    STRING,              // 1
    DEFAULT_FONT,        // 2
    DEFAULT_COLOUR,      // 3
    DEFAULT_HALIGN,      // 4
    WIDTH_LIMIT,         // 5
    LINE_HEIGHT,         // 6
    
    __SECTION1,          // 7
    HALIGN,              // 8
    VALIGN,              // 9
    WIDTH,               //10
    HEIGHT,              //11
    LEFT,                //12
    TOP,                 //13
    RIGHT,               //14
    BOTTOM,              //15
    LENGTH,              //16
    LINES,               //17
    WORDS,               //18
    GLOBAL_INDEX,        //19
    
    __SECTION2,          //20
    TW_DIRECTION,        //21
    TW_SPEED,            //22
    TW_POSITION,         //23
    TW_METHOD,           //24
    TW_SMOOTHNESS,       //25
    CHAR_FADE_T,         //26
    LINE_FADE_T,         //27
    
    __SECTION3,          //28
    HAS_CALLED_STEP,     //29
    NO_STEP_COUNT,       //30
    DATA_FIELDS,         //31
    ANIMATION_TIME,      //32
    
    __SECTION4,          //33
    LINE_LIST,           //34
    VERTEX_BUFFER_LIST,  //35
    
    __SECTION5,          //36
    EV_CHARACTER_LIST,   //37
    EV_NAME_LIST,        //38
    EV_DATA_LIST,        //39
    EV_TRIGGERED_LIST,   //40
    EV_TRIGGERED_MAP,    //41
    EV_VALUE_MAP,        //42
    EV_CHANGED_MAP,      //43
    EV_PREVIOUS_MAP,     //44
    EV_DIFFERENT_MAP,    //45
    
    __SIZE               //46
}

#macro __SCRIBBLE_ON_DIRECTX ((os_type == os_windows) || (os_type == os_xboxone) || (os_type == os_uwp) || (os_type == os_win8native) || (os_type == os_winphone))
#macro __SCRIBBLE_ON_OPENGL  !__SCRIBBLE_ON_DIRECTX
#macro __SCRIBBLE_ON_MOBILE  ((os_type == os_ios) || (os_type == os_android))

#endregion