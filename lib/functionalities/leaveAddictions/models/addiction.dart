class Addiction {
  final String key;
  final String value;

  Addiction(this.key, this.value);

  static List<Addiction> addictionList() {
    return <Addiction>[
      Addiction('tobacco', 'Consumir Tabaco'),
      Addiction('alcohol', 'Consumir Álcool'),
      Addiction("pornography", "Ver Pornografia"),
      Addiction('impulsiveShopping', "Compras Impulsivas"),
      Addiction('socialMedia', 'Consumir Álcool'),
    ];
  }
}
