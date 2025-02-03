import 'package:equatable/equatable.dart';

class DestinationModel extends Equatable {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final String about;
  final String interest1;
  final String interest2;
  final String interest3;
  final String interest4;
  final double rating;
  final int price;
  final List<String> miniImageUrl;

  DestinationModel(
      {required this.id,
      required this.name,
      required this.country,
      required this.imageUrl,
      required this.about,
      required this.interest1,
      required this.interest2,
      required this.interest3,
      required this.interest4,
      required this.rating,
      required this.price,
      required this.miniImageUrl});

  factory DestinationModel.fromJson(String id, Map<String, dynamic> json) =>
      DestinationModel(
          id: id,
          name: json['name'],
          country: json['country'],
          imageUrl: json['imageUrl'],
          about: json['detail']['about'],
          interest1: json['interest']['interest1'],
          interest2: json['interest']['interest2'],
          interest3: json['interest']['interest3'],
          interest4: json['interest']['interest4'],
          rating: json['rating'].toDouble(),
          price: json['price'],
          miniImageUrl: List<String>.from(json['detail']['miniImages']));

  Map<String, dynamic> toJson() => {
        'name': name,
        'country': country,
        'imageUrl': imageUrl,
        'detail': {
          'about': about,
          'miniImages': miniImageUrl,
        },
        'interest': {
          'interest1': interest1,
          'interest2': interest2,
          'interest3': interest3,
          'interest4': interest4,
        },
        'rating': rating,
        'price': price,
      };
  @override
  List<Object?> get props => throw UnimplementedError();
}
