//  Scribble v4.7.1
//  2019/05/23
//  @jujuadams
//  With thanks to glitchroy, Mark Turner, Rob van Saaze, and DragoniteSpam
//  
//  
//  For use with GMS2.2.2 and later

#region Global behaviours

#macro SCRIBBLE_HASH_NEWLINE       true  //Replaces hashes (#) with newlines (ASCII chr10) to emulate GMS1 behaviour
#macro SCRIBBLE_COLOURISE_SPRITES  true  //Whether to apply the text colour to non-animated sprites (animated sprites are always blended white)
#macro SCRIBBLE_VERBOSE            false //Enables verbose console output to aid with debugging. Turn off if all the console is getting too cluttered for you!
#macro SCRIBBLE_STEP_SIZE          (delta_time/game_get_speed(gamespeed_microseconds)) //Automatically delta times text effects (including typewriter). Set this macro to a variable to control the step size yourself

#endregion

#region Text animation defaults

#macro SCRIBBLE_DEFAULT_SPRITE_SPEED       0.1   //The default animation speed for sprites inserted into text
#macro SCRIBBLE_DEFAULT_WAVE_SIZE          4.0   //The default magnitude of the text wave animation. A value of "4" will cause the wave to extend 4 pixels above and 4 pixels below the line of text
#macro SCRIBBLE_DEFAULT_WAVE_FREQUENCY    50.0   //The default frequency of the text wave animation. Higher values cause the wave peaks to be closer together
#macro SCRIBBLE_DEFAULT_WAVE_SPEED         0.2   //The default speed of the text wave animation
#macro SCRIBBLE_DEFAULT_SHAKE_SIZE         4.0   //The default magnitude of the text shake animation. A value of "4" will cause the shake to extend 4 pixels along each axis
#macro SCRIBBLE_DEFAULT_SHAKE_SPEED        0.4   //The default speed of the text shake animation
#macro SCRIBBLE_DEFAULT_RAINBOW_WEIGHT     0.5   //The default blend weight of the rainbow effect. A value of "0.5" will equally blend the text's original colour with the rainbow colour
#macro SCRIBBLE_DEFAULT_RAINBOW_SPEED      0.01  //The default speed of the rainbow effect
#macro SCRIBBLE_DEFAULT_WOBBLE_ANGLE      60.0   //
#macro SCRIBBLE_DEFAULT_WOBBLE_FREQUENCY   0.15  //

#endregion

#region Miscellaneous advanced settings

#macro SCRIBBLE_FORCE_NO_SPRITE_ANIMATION  false    //Forces all sprite animations off. This can be useful for testing rendering without the Scribble shader set
#macro SCRIBBLE_CALL_STEP_IN_DRAW          false    //Calls scribble_step() at the start of scribble_draw() for convenience. This isn't recommended - you should keep logic and drawing separate where possible in your code!
#macro SCRIBBLE_FIX_NEWLINES               true     //The newline fix stops unexpected newline types from breaking the parser, but it can be a bit slow
#macro SCRIBBLE_SLANT_AMOUNT               4        //The x-axis displacement when using the [slant] tag
#macro SCRIBBLE_Z                          0        //The z-value for vertexes

#endregion

#region scribble_get_box() constants

enum SCRIBBLE_BOX
{
    X0, Y0, //Top left corner
    X1, Y1, //Top right corner
    X2, Y2, //Bottom left corner
    X3, Y3  //Bottom right corner
}

#endregion

#region scribble_set_glyph_property() and scribble_get_glyph_property() constants

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

#endregion

#region Sequential glyph indexing

//Normally, Scribble will try to sequentially store glyph data in an array for fast lookup.
//However, some font definitons may have disjointed character indexes (e.g. Chinese). Scribble will detect these fonts and use a ds_map instead for glyph data lookup
#macro SCRIBBLE_SEQUENTIAL_GLYPH_TRY        true
#macro SCRIBBLE_SEQUENTIAL_GLYPH_MAX_RANGE  200      //If the glyph range (min index to max index) exceeds this number, a font's glyphs will be indexed using a ds_map
#macro SCRIBBLE_SEQUENTIAL_GLYPH_MAX_HOLES  0.50     //Fraction (0 -> 1). If the number of holes exceeds this proportion, a font's glyphs will be indexed using a ds_map

#endregion

#region Command tag customisation

#macro SCRIBBLE_COMMAND_TAG_OPEN      ord("[") //Character used to open a command tag. First 127 ASCII chars only
#macro SCRIBBLE_COMMAND_TAG_CLOSE     ord("]") //Character used to close a command tag. First 127 ASCII chars only
#macro SCRIBBLE_COMMAND_TAG_ARGUMENT  ord(",") //Character used to delimit a command parameter inside a command tag. First 127 ASCII chars only

#endregion

#region Shader constants

//SCRIBBLE_MAX_FLAGS or SCRIBBLE_MAX_DATA_FIELDS must match the corresponding values in shader shScribble
#macro SCRIBBLE_MAX_FLAGS               5  //The maximum number of flags. "Flags" are boolean values that can be set per character, and are sent into shScribble to trigger animation effects etc.
#macro SCRIBBLE_MAX_DATA_FIELDS         9  //The maximum number of data fields. "Data fields" are misc 
#macro SCRIBBLE_MAX_LINES            1000  //Maximum number of lines in a textbox.

#macro SCRIBBLE_DEFAULT_DATA_FIELDS  [SCRIBBLE_DEFAULT_WAVE_SIZE, SCRIBBLE_DEFAULT_WAVE_FREQUENCY, SCRIBBLE_DEFAULT_WAVE_SPEED,\
                                      SCRIBBLE_DEFAULT_SHAKE_SIZE, SCRIBBLE_DEFAULT_SHAKE_SPEED,\
                                      SCRIBBLE_DEFAULT_RAINBOW_WEIGHT, SCRIBBLE_DEFAULT_RAINBOW_SPEED,\
                                      SCRIBBLE_DEFAULT_WOBBLE_ANGLE, SCRIBBLE_DEFAULT_WOBBLE_FREQUENCY]

#endregion