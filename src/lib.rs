use zed_extension_api as zed;

struct TyphoonZed {}

impl zed::Extension for TyphoonZed {
    fn new() -> Self {
        Self {}
    }
}

zed::register_extension!(TyphoonZed);
