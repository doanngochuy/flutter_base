import 'abstract_state.dart';

class ImageUrl extends AppState<String> {
  final String imageUrl;

  const ImageUrl(this.imageUrl) : super(imageUrl);

  @override
  List<Object?> get props => [data];
}
