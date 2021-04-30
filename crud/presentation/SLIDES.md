---
marp: true
theme: sonat
size: 16:9
html: true

header: Fagdag @ Sonat, April 2021
footer: ![w:16](https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg)&nbsp;@arnemolland
---

# Data-fetching

![bg right](https://media.giphy.com/media/LGzrggUppEBdm/giphy.gif)

- REST/gRPC/WebSockets
- Mappe JSON til dataklasser (og omvendt)
- Håndtere feil
- Lime sammen data og grensesnitt

---

# http

Bibliotek med `fetch`-aktig syntaks.

```dart
final res = await get(uri);

final json = jsonDecode(res.body);
```

---

# Klasser i Dart

```dart
class Foo {
  String x;
  String? y;
  final String? z;
  late String? _x;
}
```

---

# Keywords

```dart
final // Immutable
static // Statisk
const // Compile-time konstant
late // Lazy initialisering
```

---

# Private felter?

I Dart er privacy på library-nivå i stedet for klasse-nivå. _By default_ er en fil ett library.

```dart
String _private; // Privat
String get private => _private; // Getter
```

---

# Konstruktører

Kan ta positional, optional og "named" parametre.

---

# Positional

```dart
Foo(this.x, this.y, this.z);

final foo = Foo(var1, var2, var3);
```

---

# Optional

```dart
Foo(this.x, [this.y, this.z]);

final foo = Foo(var1, var2);
```

---

# Named

```dart
Foo({this.x, this.y, this.z});

final foo = Foo(x: var1, y: var2, z: var3);
```

---

# Men hva med Flutter?

Noen APIer, særlig Flutter widgets' konstruktører, bruker bare navngitte parametre. Hvordan blandes det med null-safety?

```dart
Foo({required this.bar});
```

---

# Data-klasser

Vi ønsker som oftest å ha immutable klasser når det kommer til dataklasser.

```dart
class Data {
  final String id;
  final String name;
  final bool valid;
}
```

```dart
Data({
  required this.id,
  required this.name,
  required this.valid
});
```

---

# Til og fra JSON

Vi bruker metoden `jsonDecode()` for å konvertere en JSON-streng til en `Map<String, dynamic>`.

```dart
Map<String, dynamic> json = jsonDecode(jsonString);
```

---

# Men i en klasse?

Vi kan lage en statisk `factory`-konstruktør!

```dart
factory Data.fromJson(Map<String, dynamic> json) {
  return Data(
      id: json['id'],
      name: json['name'],
      valid: json['valid'],
    );
}
```

---

# Og fra objekt til JSON...

```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'valid': valid,
  };
}
```

---

# Finnes det enklere måter?

Ja! Det finnes ingen Gson/Moshi-ekvivalent pga. refleksjon, men kodegenerering brukes i stedet.

> Since reflection makes all code implicitly used by default, it makes tree shaking difficult. The tools cannot know what parts are unused at runtime, so the redundant code is hard to strip away. App sizes cannot be easily optimized when using reflection.

---

# json_serializable

```dart
part 'data.g.dart';

@JsonSerializable()
class Data {
  final String id;
  final String name;
  final bool valid;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
```

---

# Oppgave!