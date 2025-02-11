// Copyright 2024 splitkb.com (support@splitkb.com)
// SPDX-License-Identifier: GPL-2.0-or-later

#include QMK_KEYBOARD_H

enum layers {
    _QWERTY = 0,
    _SYMBOLS,
    _NUMPAD,
    _NUMROW,
};


// Aliases for readability
#define MACLOCK LGUI(LCTL(KC_Q))

#define CTL_QUOT MT(MOD_RCTL, KC_QUOTE)


// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/*
 * Base Layer: QWERTY
 *
 * ,-------------------------------------------.                              ,-------------------------------------------.
 * |  Tab   |   Q  |   W  |   E  |   R  |   T  |                              |   Y  |   U  |   I  |   O  |   P  |  Bksp  |
 * |--------+------+------+------+------+------|                              |------+------+------+------+------+--------|
 * |  Ctrl  |   A  |   S  |   D  |   F  |   G  |                              |   H  |   J  |   K  |   L  | ;  : |Ctrl/' |
 * |--------+------+------+------+------+------+-------------.  ,-------------+------+------+------+------+------+--------|
 * | LShift |   Z  |   X  |   C  |   V  |   B  | Shift|Hyper |  |  ESC | Shift|   N  |   M  | ,  < | . >  | /  ? | RShift |
 * `----------------------+------+------+------+------+------|  |------+------+------+------+------+----------------------'
 *                        |Left  | Right| GUI  | Bspc | ALT  |  |  ALT | Enter| Space| Up   | Down |
 *                        |      |      | Enter|      |      |  |      |      |      |      |      |
 *                        `----------------------------------'  `----------------------------------'
 * ,-----------------------------------.                                              ,-----------------------------------.
 * | MUTE | ____ | _____ | ____ | ____ |                                              | MUTE | ____ | _____ | ____ | ____ |
 * `-----------------------------------'                                              `-----------------------------------'
 */
    [_QWERTY] = LAYOUT_split_3x6_5_hlc(
     KC_TAB  , KC_Q ,  KC_W   ,  KC_E  ,   KC_R ,   KC_T ,                                        KC_Y,   KC_U ,  KC_I ,   KC_O ,  KC_P , KC_BSLS,
     KC_LCTL , KC_A ,  KC_S   ,  KC_D  ,   LT(_NUMPAD, KC_F) ,   LT(_SYMBOLS, KC_G),                           KC_H,   KC_J ,  KC_K ,   KC_L ,KC_SCLN,CTL_QUOT,
     KC_LSFT , KC_Z ,  KC_X   ,  KC_C  ,   KC_V ,   KC_B , OSM(MOD_LSFT),  HYPR(KC_5),     KC_ESC  , OSM(MOD_RSFT), KC_N,   KC_M ,KC_COMM, KC_DOT ,KC_SLSH, KC_RSFT,
                                KC_LEFT , KC_RIGHT, KC_LGUI, KC_BSPC , LT(_NUMROW, KC_LALT),     LT(_NUMROW, KC_RALT)    , KC_ENT , LT(_SYMBOLS, KC_SPC), KC_UP, KC_DOWN,
     KC_MUTE, KC_NO,  KC_NO, KC_NO, KC_NO,                                                                KC_MUTE, KC_NO, KC_NO, KC_NO, KC_NO
    ),

 /*
  * Symbol Layer template
  *
  * ,-------------------------------------------.                              ,-------------------------------------------.
  * |        |   !  |   @  |   {  |  {   |   |  |                              |   F1 | F2   |      |      |  *   |        |
  * |--------+------+------+------+------+------|                              |------+------+------+------+------+--------|
  * |        |   &  |   $  |   (  |  )   |  `   |                              | Left | Down | Up   | Right|     |        |
  * |--------+------+------+------+------+------+-------------.  ,-------------+------+------+------+------+------+--------|
  * |        |   #  |   ^  |   [  |   ]  |  ~   |      |      |  |      |      |  _   |  -   |  =   |   %  |      |        |
  * `----------------------+------+------+------+------+------|  |------+------+------+------+------+----------------------'
  *                        |      |      |      |      |      |  |      |      |      |      |      |
  *                        |      |      |      |      |      |  |      |      |      |      |      |
  *                        `----------------------------------'  `----------------------------------'
  * ,-----------------------------------.                                              ,-----------------------------------.
  * |      |      |       |      |      |                                              |      |      |       |      |      |
  * `-----------------------------------'                                              `-----------------------------------'
  */
     [_SYMBOLS] = LAYOUT_split_3x6_5_hlc(
       _______, KC_EXCLAIM,   KC_AT,        KC_LEFT_CURLY_BRACE, KC_RIGHT_CURLY_BRACE, KC_PIPE,                                      KC_F1,         KC_F2,   _______, _______,   KC_ASTERISK, _______,
       _______, KC_AMPERSAND, KC_DOLLAR,    KC_LEFT_PAREN,       KC_RIGHT_PAREN,       KC_GRAVE,                                     KC_LEFT,       KC_DOWN, KC_UP,   KC_RIGHT,  _______, _______,
       _______, KC_HASH,      KC_CIRCUMFLEX,KC_LBRC,             KC_RBRC,              KC_TILDE,_______, _______,  _______, _______, KC_UNDERSCORE, KC_MINUS,KC_EQUAL,KC_PERCENT,_______, _______,
                                  _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,

       _______, _______, _______, _______, _______,                                                       _______, _______, _______, _______, _______
     ),

 /*
  * Numpad Layer template
  *
  * ,-------------------------------------------.                              ,-------------------------------------------.
  * |        |      |      |      |      |      |                              |      |  7   |   8  |  9   |     |        |
  * |--------+------+------+------+------+------|                              |------+------+------+------+------+-------|
  * |        |      |      |      |      |      |                              |      |  4   |   5  |  6   |     |        |
  * |--------+------+------+------+------+------+-------------.  ,-------------+------+------+------+------+------+-------|
  * |        |      |      |      |      |      |      |      |  |      |      |      |  1   |   2  |  3   |     |        |
  * `----------------------+------+------+------+------+------|  |------+------+------+------+------+----------------------'
  *                        |      |      | Space| BSPC |      |  |      |  0   |      |      |      |
  *                        |      |      |      |      |      |  |      |      |      |      |      |
  *                        `----------------------------------'  `----------------------------------'
  * ,-----------------------------------.                                              ,-----------------------------------.
  * |      |      |       |      |      |                                              |      |      |       |      |      |
  * `-----------------------------------'                                              `-----------------------------------'
  */
     [_NUMPAD] = LAYOUT_split_3x6_5_hlc(
       _______, _______, _______, _______, _______, _______,                                     _______, KC_KP_7,  KC_KP_8,  KC_KP_9,  KC_KP_MINUS, _______,
       _______, _______, _______, _______, _______, _______,                                     KC_COMM, KC_KP_4,  KC_KP_5,  KC_KP_6,  KC_KP_PLUS, _______,
       _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, KC_DOT, KC_KP_1,  KC_KP_2,  KC_KP_3,  KC_SLSH, _______,
                                  _______, _______, KC_SPC, KC_BSPC, _______, _______, KC_KP_0, KC_KP_ENTER, _______, _______,

       _______, _______, _______, _______, _______,                                                       _______, _______, _______, _______, _______
     ),

/*
 * Numrow Layer template
 *
 * ,-------------------------------------------.                              ,-------------------------------------------.
 * |        |      |      |      |      |      |                              |      |      |      |      |      |        |
 * |--------+------+------+------+------+------|                              |------+------+------+------+------+--------|
 * |        |   1  |  2   |  3   |  4   |  5   |                              |   6  |  7   |  8   |   9  |   0  |        |
 * |--------+------+------+------+------+------+-------------.  ,-------------+------+------+------+------+------+--------|
 * |        |      |      |      |      |      |      |      |  |      |      |      |      |      |      |      |        |
 * `----------------------+------+------+------+------+------|  |------+------+------+------+------+----------------------'
 *                        |      |      |      |      |      |  |      |      |      |      |      |
 *                        |      |      |      |      |      |  |      |      |      |      |      |
 *                        `----------------------------------'  `----------------------------------'
 * ,-----------------------------------.                                              ,-----------------------------------.
 * |      |      |       |      |      |                                              |      |      |       |      |      |
 * `-----------------------------------'                                              `-----------------------------------'
 */
    [_NUMROW] = LAYOUT_split_3x6_5_hlc(
      _______, _______, _______, _______, _______, _______,                                     _______, _______, _______, _______, _______, _______,
      _______, G(KC_1), G(KC_2), G(KC_3), G(KC_4), G(KC_5),                                     G(KC_6), G(KC_7), G(KC_8), G(KC_9), G(KC_0), _______,
      _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
                                 _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,

      _______, _______, _______, _______, _______,                                                       _______, _______, _______, _______, _______
    ),



// /*
//  * Halcyon Layer template
//  *
//  * ,-------------------------------------------.                              ,-------------------------------------------.
//  * |        |      |      |      |      |      |                              |      |      |      |      |      |        |
//  * |--------+------+------+------+------+------|                              |------+------+------+------+------+--------|
//  * |        |      |      |      |      |      |                              |      |      |      |      |      |        |
//  * |--------+------+------+------+------+------+-------------.  ,-------------+------+------+------+------+------+--------|
//  * |        |      |      |      |      |      |      |      |  |      |      |      |      |      |      |      |        |
//  * `----------------------+------+------+------+------+------|  |------+------+------+------+------+----------------------'
//  *                        |      |      |      |      |      |  |      |      |      |      |      |
//  *                        |      |      |      |      |      |  |      |      |      |      |      |
//  *                        `----------------------------------'  `----------------------------------'
//  * ,-----------------------------------.                                              ,-----------------------------------.
//  * |      |      |       |      |      |                                              |      |      |       |      |      |
//  * `-----------------------------------'                                              `-----------------------------------'
//  */
//     [_LAYERINDEX] = LAYOUT_split_3x6_5_hlc(
//       _______, _______, _______, _______, _______, _______,                                     _______, _______, _______, _______, _______, _______,
//       _______, _______, _______, _______, _______, _______,                                     _______, _______, _______, _______, _______, _______,
//       _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
//                                  _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
//
//       _______, _______, _______, _______, _______,                                                       _______, _______, _______, _______, _______
//     ),
};

#ifdef ENCODER_ENABLE
bool encoder_update_user(uint8_t index, bool clockwise) {

    if (index == 0) {
        // Volume control
        if (clockwise) {
            tap_code(KC_VOLU);
        } else {
            tap_code(KC_VOLD);
        }
    } else if (index == 1) {
        // Volume control
        if (clockwise) {
            tap_code(KC_VOLU);
        } else {
            tap_code(KC_VOLD);
        }
    } else if (index == 2) {
        // Page up/Page down
        if (clockwise) {
            tap_code(KC_PGDN);
        } else {
            tap_code(KC_PGUP);
        }
    } else if (index == 3) {
        // Page up/Page down
        if (clockwise) {
            tap_code(KC_PGDN);
        } else {
            tap_code(KC_PGUP);
        }
    }
    return false;
}
#endif
