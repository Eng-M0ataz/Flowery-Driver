String imageFixer(String? image) {
  if (image == null || image.isEmpty) {
    return '';
  }
  if (!image.startsWith('http')) {
    image = 'https://flower.elevateegy.com/uploads/$image';
    return image;
  }
  return image;
}