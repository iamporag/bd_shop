
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'review_image_state.dart';

class ReviewImageCubit extends Cubit<ReviewImageState> {
   
  ReviewImageCubit() : super(ReviewImageInitial());

List <XFile> selectedReviewImages = [];

    Future<void> picImage() async {
    final ImagePicker _picker = ImagePicker();
     await _picker.pickMultiImage().then((value) {
      selectedReviewImages = [...selectedReviewImages, ...value];
       print({
        "Message" : "Image Added",
        "Length" : selectedReviewImages.length,
        });
     });
      emit(ReviewImageAdded(selectedReviewImages));
  }

  void removeImage (int index) {
    List<XFile> updateList = List.from(selectedReviewImages);
    updateList.removeAt(index);
    selectedReviewImages = updateList;
    emit(ReviewImageRemoved(selectedReviewImages));
     print({
        "Message" : "Image removed",
        "Length" : selectedReviewImages.length,
        });
  }
}
