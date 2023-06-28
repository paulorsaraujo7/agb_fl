//Enum for the institution type
enum InstitutionType {
  emergence,
  other_services,
  app,
}
class Institution {
  late final String short; //a short to the name
  late final String name;
  late final String phone;
  late final String explanation;
  late final String url;
  late final String icon;
  late final InstitutionType institutionType;

  Institution({
    required this.short,
    required this.name,
    required this.phone,
    required this.explanation,
    this.url = "",
    required this.institutionType,
    this.icon = "",
  });

}

//OK_TODO (CÓDIGO): O TIPO DEVE VIR DE UMA ENUM


