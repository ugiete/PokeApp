class PokemonModel {
  final int index;
  final String name;
  final String sprite;
  final List<String> types;

  const PokemonModel(this.index, this.name, this.sprite, this.types);

  PokemonModel.fromJson(Map<String, dynamic> json)
    : index = json["id"],
      name = json["name"],
      sprite = json["sprites"]["front_default"],
      types = [];
}