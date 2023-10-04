enum Professions {
  mechanics(
      name: 'Mechanics', imgPath: 'assets/images/professions/mechanic.jpeg'),
  tailors(name: 'Tailors', imgPath: 'assets/images/professions/tailoring.jpeg'),
  capenters(
      name: 'Capenters', imgPath: 'assets/images/professions/capenter.jpeg'),
  plumbers(
      name: 'Plumbings', imgPath: 'assets/images/professions/plumbing.jpeg'),
  potters(name: 'Potters', imgPath: 'assets/images/professions/potter.jpeg'),
  shoeMakers(
      name: 'Shoe Makers',
      imgPath: 'assets/images/professions/shoe making.jpeg'),
  painters(
      name: 'Painters', imgPath: 'assets/images/professions/painting.jpeg'),
  chef(name: 'Chef', imgPath: 'assets/images/professions/chef.jpeg');

  final String name;
  final String imgPath;

  const Professions({
    required this.name,
    required this.imgPath,
  });
}
