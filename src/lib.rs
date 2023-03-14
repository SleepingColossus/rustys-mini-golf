mod animated_sprite;
mod background;
mod ball;
mod constants;
mod game;
mod html;
mod level;
mod point;
mod sprite_sheet;

use std::cell::RefCell;
use std::rc::Rc;
use wasm_bindgen::prelude::*;

// TODO figure out how to use method in html.rs instead of this
fn request_animation_frame(f: &Closure<dyn FnMut()>) {
    let html = html::Html::new();

    html.window
        .request_animation_frame(f.as_ref().unchecked_ref())
        .expect("should register `requestAnimationFrame` OK");
}

#[wasm_bindgen(start)]
pub fn run() -> Result<(), JsValue> {
    let f = Rc::new(RefCell::new(None));
    let g = f.clone();

    let html = html::Html::new();
    let mut background = background::Background::new(&html);
    let mut game = game::Game::new();

    let mut last_epoch: f64 = js_sys::Date::now();

    *g.borrow_mut() = Some(Closure::wrap(Box::new(move || {
        let epoch = js_sys::Date::now();
        let delta_time = epoch - last_epoch;

        background.update(delta_time);
        game.update(delta_time);
        background.draw(&html.context_bg);
        game.draw(&html.canvas_game, &html.context_game);

        last_epoch = epoch;
        request_animation_frame(f.borrow().as_ref().unwrap());
    }) as Box<dyn FnMut()>));

    request_animation_frame(g.borrow().as_ref().unwrap());
    Ok(())
}
