#include QMK_KEYBOARD_H

enum layer_names {
    _QWERTY,
    _SYMBOLS,
    _NUMPAD
};

// Mac-specific macros
#define MACCOPY LGUI(KC_C)
#define MACPAST LGUI(KC_V)
#define MACUNDO LGUI(KC_Z)
#define MACREDO LGUI(KC_Y)
#define MACLOCK LGUI(LCTL(KC_Q))

#define BROWSER_SEARCH LGUI(KC_F) 
#define BROWSER_NEWTAB LGUI(KC_T) 
#define BROWSER_CLOSETTAB LGUI(KC_W) 
#define BROWSER_NEXTTAB LAG(KC_RIGHT) 
#define BROWSER_PREVTAB LAG(KC_LEFT) 


/****************************************************************************************************
*
* Keymap: Default Layer in Qwerty
*
* ,-------------------------------------------------------------------------------------------------------------------.
* | Esc    |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |  F8  |  F9  |  F10 |  F12 | PSCR | SLCK | PAUS |  FN0 |  BOOT  |
* |--------+------+------+------+------+------+---------------------------+------+------+------+------+------+--------|
* | =+     |  1!  |  2@  |  3#  |  4$  |  5%  |                           |  6^  |  7&  |  8*  |  9(  |  0)  | -_     |
* |--------+------+------+------+------+------|                           +------+------+------+------+------+--------|
* | Tab    |   Q  |   W  |   E  |   R  |   T  |                           |   Y  |   U  |   I  |   O  |   P  | \|     |
* |--------+------+------+------+------+------|                           |------+------+------+------+------+--------|
* | Ctrl   |   A  |   S  |   D  |   F  |   G  |                           |   H  |   J  |   K  |   L  |  ;:  | '"     |
* |--------+------+------+------+------+------|                           |------+------+------+------+------+--------|
* | Shift  |   Z  |   X  |   C  |   V  |   B  |                           |   N  |   M  |  ,.  |  .>  |  /?  | Shift  |
* `--------+------+------+------+------+-------                           `------+------+------+------+------+--------'
*          | `~   | INS  | Left | Right|                                         | Up   | Down |  [{  |  ]}  |
*          `---------------------------'                                         `---------------------------'
*                                        ,-------------.         ,-------------.
*                                        | Cmd  | Alt  |         | Alt  | Cmd  |
*                                 ,------|------|------|         |------+------+------.
*                                 |      |      | Home |         | PgUp |      |      |
*                                 | BkSp | Del  |------|         |------|Return| Space|
*                                 |      |      | End  |         | PgDn |      |      |
*                                 `--------------------'         `--------------------'
*/


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[_QWERTY] = LAYOUT(

           KC_ESC, KC_F1  ,KC_F2  ,KC_F3  ,KC_F4  ,KC_F5  ,KC_F6  ,KC_F7  ,KC_F8,
           KC_EQL, KC_1   ,KC_2   ,KC_3   ,KC_4   ,KC_5   ,
           KC_TAB, KC_Q   ,KC_W   ,KC_E   ,KC_R   ,KC_T   ,
           KC_LCTL,KC_A   ,KC_S   ,KC_D   ,LT(_NUMPAD, KC_F), KC_G   ,
           KC_LSFT,KC_Z   ,KC_X   ,KC_C   ,KC_V   ,KC_B   ,
                   KC_GRV ,KC_INS ,KC_LEFT,KC_RGHT,
			   HYPR(KC_7),HYPR(KC_8),
				    KC_HYPR,
                   KC_LGUI, KC_BSPC, HYPR(KC_5),

    KC_F9  ,KC_F10 ,KC_F11 ,KC_F12 ,KC_PSCR ,MACLOCK  ,KC_PAUS, TG(_NUMPAD), RESET,
	KC_6   ,KC_7   ,KC_8   ,KC_9   ,KC_0   ,KC_MINS,
	KC_Y   ,KC_U   ,KC_I   ,KC_O   ,KC_P   ,KC_BSLS,
	KC_H   ,KC_J   ,KC_K   ,KC_L   ,KC_SCLN,RCTL_T(KC_QUOT),
	KC_N   ,KC_M   ,KC_COMM,KC_DOT ,KC_SLSH,KC_RSFT,
		KC_UP  ,KC_DOWN,KC_LBRC,KC_RBRC,
           KC_RALT, KC_ESC,
           KC_PGUP,
           HYPR(KC_5), KC_ENTER , LT(_SYMBOLS, KC_SPACE)
    ),

[_SYMBOLS] = LAYOUT(
         _______,  _______,  _______,  _______,  _______,  _______, _______, _______, _______,
         _______,  _______,  HYPR(KC_1),  HYPR(KC_2),  HYPR(KC_3),  _______,
         _______,  KC_EXCLAIM,  KC_AT,  KC_LEFT_CURLY_BRACE,  KC_RIGHT_CURLY_BRACE,  KC_PIPE,
         _______,  KC_AMPERSAND,  KC_DOLLAR,  KC_LEFT_PAREN,  KC_RIGHT_PAREN,  KC_GRAVE,
         _______,  KC_HASH,  KC_CIRCUMFLEX,  KC_LBRACKET,  KC_RBRACKET,  KC_TILDE,
                   _______,  _______,  _______,  _______,
                             _______,  _______,
                                       _______,
                   _______, _______,  _______,
         _______,  _______, _______,  _______,  _______,  _______, _______, _______, _______,
         _______,  _______, _______,  _______,  _______,  _______,
         BROWSER_PREVTAB,  BROWSER_CLOSETTAB, BROWSER_NEWTAB, BROWSER_NEXTTAB,  KC_ASTERISK,  BROWSER_SEARCH,
         KC_LEFT,  KC_DOWN, KC_UP,  KC_RIGHT,  _______,  _______,
         KC_UNDERSCORE,  KC_MINUS,  KC_EQUAL,  KC_PERCENT,  _______,  _______,
                   _______,  _______,  _______,  _______,
         _______,  _______,
         _______,
         _______,  _______,  _______
    ),

[_NUMPAD] = LAYOUT(
         _______,  _______,  _______,  _______,  _______,  _______, _______, _______, _______,
         _______,  _______,  _______,  _______,  _______,  _______,
         _______,  _______,  _______,  _______,  _______,  _______,
         _______,  _______,  _______,  _______,  _______,  _______,
         _______,  _______,  _______,  _______,  _______,  _______,
                   _______,  _______,  _______,  _______,
                             _______,  _______,
                                       _______,
                   KC_SPACE, _______,  _______,
         _______,  _______,  _______,  _______,  _______,  _______, _______, _______, _______,
         _______,  _______,  KC_KP_EQUAL,  KC_KP_SLASH,  KC_KP_ASTERISK,  _______,
         _______,  KC_KP_7,  KC_KP_8,  KC_KP_9,  KC_KP_MINUS,  _______,
         _______,  KC_KP_4,  KC_KP_5,  KC_KP_6,  KC_KP_PLUS,  _______,
         _______,  KC_KP_1,  KC_KP_2,  KC_KP_3,  KC_SLSH,  _______,
                   _______,  _______,  KC_KP_DOT,  KC_KP_ENTER,
         _______,  _______,
         _______,
         _______,  _______,  KC_KP_0
    ),
};

void matrix_init_user(void) {

}

void matrix_scan_user(void) {

}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  return true;
}

void led_set_user(uint8_t usb_led) {

}

layer_state_t layer_state_set_user(layer_state_t state) {
    switch (get_highest_layer(state)) {
    case _SYMBOLS:
        writePinLow(LED_NUM_LOCK_PIN);
        writePinHigh(LED_CAPS_LOCK_PIN);
        writePinHigh(LED_SCROLL_LOCK_PIN);
        writePinHigh(LED_COMPOSE_PIN);
        break;
    case _NUMPAD:
        writePinLow(LED_SCROLL_LOCK_PIN);
        writePinHigh(LED_NUM_LOCK_PIN);
        writePinHigh(LED_CAPS_LOCK_PIN);
        writePinHigh(LED_COMPOSE_PIN);
        break;
    default: //  for any other layers, or the default layer
        writePinLow(LED_CAPS_LOCK_PIN);
        writePinHigh(LED_NUM_LOCK_PIN);
        writePinHigh(LED_SCROLL_LOCK_PIN);
        writePinHigh(LED_COMPOSE_PIN);
        break;
    }
  return state;
}

bool led_update_user(led_t led_state) {
    // Disable led_update_kb() so that layer indication code doesn't get overridden.
    return false;
}
