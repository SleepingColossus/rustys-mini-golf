mod ball;
mod game;
mod html;
mod sprite_sheet;
mod constants;
mod point;

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
    let mut game = game::Game::new();

    *g.borrow_mut() = Some(Closure::wrap(Box::new(move || {
        game.update();
        game.draw(&html.canvas, &html.context);

        request_animation_frame(f.borrow().as_ref().unwrap());
    }) as Box<dyn FnMut()>));

    request_animation_frame(g.borrow().as_ref().unwrap());
    Ok(())
}
