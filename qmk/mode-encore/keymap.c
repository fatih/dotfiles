/* Copyright 2022 Gondolindrim
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include QMK_KEYBOARD_H

#define MACLOCK LGUI(LCTL(KC_Q))

// Left-hand home row mods
#define HOME_A LCTL_T(KC_A)
#define HOME_S LALT_T(KC_S)
#define HOME_D LGUI_T(KC_D)
#define HOME_F LSFT_T(KC_F)

// Right-hand home row mods
#define HOME_J RSFT_T(KC_J)
#define HOME_K RGUI_T(KC_K)
#define HOME_L RALT_T(KC_L)
#define HOME_SCLN RCTL_T(KC_SCLN)

// Tap Dance declarations
enum {
    TD_9,
    TD_MUTE,
};

// Tap Dance definitions
tap_dance_action_t tap_dance_actions[] = {
    // Tap once for 9, twice for CMD + SHIFT + 3 (Screenshot)
    [TD_9] = ACTION_TAP_DANCE_DOUBLE(KC_9, LSG(KC_3)),

    // Tap once for ESC twice for mute
    [TD_MUTE] = ACTION_TAP_DANCE_DOUBLE(KC_ESC, KC_MUTE),
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[0] = LAYOUT_65_ansi_blocker( /* Base */
    KC_GRAVE     , KC_1    , KC_2    , KC_3    , KC_4   , KC_5  , KC_6   , KC_7   , KC_8    , TD(TD_9), KC_0       , KC_MINS         , KC_EQL , KC_BSPC, KC_ESC,
    KC_TAB       , KC_Q    , KC_W    , KC_E    , KC_R   , KC_T  , KC_Y   , KC_U   , KC_I    , KC_O    , KC_P       , KC_LBRC         , KC_RBRC, KC_BSLS, KC_VOLU,
    KC_LCTL      , KC_A    , KC_S    , KC_D    , KC_F   , KC_G  , KC_H   , KC_J   , KC_K    , KC_L    , KC_SCLN    , RCTL_T(KC_QUOT) ,          KC_ENT , KC_VOLD,
    OSM(MOD_LSFT), KC_Z    , KC_X    , KC_C    , KC_V   , KC_B  , KC_N   , KC_M   , KC_COMM , KC_DOT  , KC_SLSH    , OSM(MOD_RSFT)   ,          KC_UP  , TD_MUTE ,
    MACLOCK      , KC_LALT , KC_LGUI,                             LT(1, KC_SPC),              KC_RGUI , KC_RALT    ,                  KC_LEFT , KC_DOWN, KC_RGHT
),

[1] = LAYOUT_65_ansi_blocker(
    KC_ESC  , KC_F1  , KC_F2  , KC_F3  , KC_F4  , KC_F5  , KC_F6  , KC_F7  , KC_F8  , KC_F9  , KC_F10 , KC_F11 , KC_F12 , KC_TRNS, KC_MUTE,
    KC_TRNS , KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, DT_UP  , DT_DOWN, DT_PRNT, KC_VOLU,
    KC_TRNS , KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_LEFT, KC_DOWN, KC_UP  , KC_RGHT, KC_TRNS, KC_TRNS, KC_TRNS, KC_VOLD,
    KC_TRNS , KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_BSPC, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, QK_BOOT,
    KC_TRNS , KC_TRNS, KC_TRNS,                            KC_TRNS,                   KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS
)


};
