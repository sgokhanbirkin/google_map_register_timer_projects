// ignore_for_file: public_member_api_docs, sort_constructors_first

class PlaceSearch {
  final String description;
  final String placeId;

  PlaceSearch({
    required this.description,
    required this.placeId,
  });

  factory PlaceSearch.fromJson(Map<String, dynamic> json) => PlaceSearch(
        description: json["description"],
        placeId: json["place_id"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "place_id": placeId,
      };
}
