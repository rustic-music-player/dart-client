use rustic_api::models::AlbumModel;
use allo_isolate::IntoDart;
use allo_isolate::ffi::DartCObject;

// TODO: This should be generated
pub struct DartAlbumModel(pub(crate) AlbumModel);

// TODO: this could be derivable
impl IntoDart for DartAlbumModel {
    fn into_dart(self) -> DartCObject {
        unimplemented!("not sure how to pass a struct yet")
    }
}
