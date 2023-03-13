use wasm_bindgen::JsCast;

pub struct Html {
    pub window: web_sys::Window,
    pub document: web_sys::Document,
    pub canvas: web_sys::HtmlCanvasElement,
    pub context: web_sys::CanvasRenderingContext2d,
}

impl Html {
    pub fn new() -> Self {
        let window = web_sys::window().expect("no global `window` exists");
        let document = window.document().expect("should have a document on window");
        let canvas = document.get_element_by_id("canvas").unwrap();
        let canvas = canvas
            .dyn_into::<web_sys::HtmlCanvasElement>()
            .map_err(|_| ())
            .unwrap();
        let context = canvas
            .get_context("2d")
            .unwrap()
            .unwrap()
            .dyn_into::<web_sys::CanvasRenderingContext2d>()
            .unwrap();

        Self {
            window,
            document,
            canvas,
            context,
        }
    }

    // TODO figure out how to use this method instead of one in main
    // pub fn request_animation_frame(&self, f: &Closure<dyn FnMut()>) {
    //     &self.window
    //         .request_animation_frame(f.as_ref().unchecked_ref())
    //         .expect("should register `requestAnimationFrame` OK");
    // }

    pub fn get_image_by_id(&self, image_id: &str) -> web_sys::HtmlImageElement {
        self.document
            .get_element_by_id(image_id)
            .unwrap()
            .dyn_into::<web_sys::HtmlImageElement>()
            .map_err(|_| ())
            .unwrap()
    }
}
