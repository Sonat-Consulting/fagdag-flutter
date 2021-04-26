---
marp: true
theme: sonat
size: 16:9
html: true

header: Fagdag @ Sonat, April 2021
footer: ![w:16](https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg)&nbsp;@arnemolland
---

# Animasjoner

![bg right w:512](https://raw.githubusercontent.com/Sonat-Consulting/fagdag-flutter-april-2021/animations/animasjoner/assets/icon/foreground.svg?token=ADGXSKH3SABRFOH3XLKYMPLAQ3ADY)

Hvordan bli UX-erens drøm

---

![bg right](https://media.giphy.com/media/l2JhL0Gpfbvs4Y07K/giphy.gif)

# Hva er en animasjon?

- En animasjon er bilder i bevegelse

- En animasjon innebærer endring over tid

- Animasjoner kan løfte brukeropplevelsen

- Animasjoner kan skade brukeropplevelsen

---

![bg right w:512](https://media.giphy.com/media/3owyoXMzSPGjbsQ5uE/giphy.gif)

# Interpolasjon

> ... en prosess for å tilnærme en funksjon i et punkt ved hjelp av kjente funksjonsverdier i nærliggende punkt

---

# Linær interpolasjon

![bg right](assets/gifs/linear_interpolation.gif)

---

# Kurver

![bg right](assets/gifs/bezier_interpolation.gif)

---

# Byggeklosser i Flutter

- [Animation](https://api.flutter.dev/flutter/animation/Animation-class.html) - holder en gjeldende state for en animasjon, som f.eks. om den er startet, stoppet, går fremover eller bakover, men vet ikke om hva som skjer på skjermen.

- [AnimationController](https://api.flutter.dev/flutter/animation/AnimationController-class.html) - implementerer `Animation` og fungerer som brukes til å styre og manipulere en animasjon. Holder en binding til skjermens tickrate.

- [Tween](https://api.flutter.dev/flutter/animation/Tween-class.html) - interpolerer mellom datapunkter og lager mapping mellom en input range og en output range. Ofte brukt med tall, f.eks. fra 0 til 1, men kan også brukes med f.eks. farger (se [ColorTween](https://api.flutter.dev/flutter/animation/ColorTween-class.html)).

Alle animasjoner i Flutter arver fra `Listenable`, og vi kan lytte til enhver endring i staten til en animasjon, f.eks. når den har startet eller stoppet.

---

# `AnimationController`

Instansieres med en referanse til `vsync` som holder informasjon om skjermens tickrate.

```dart
late AnimationController controller;

@override
void initState() {
  super.initState();
  controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );
}

@override
Widget build(BuildContext context) {
  return Container();
}
```

---

# Avspilling

```dart
// Starter animasjon
controller.forward();

// Pauser animasjon
controller.stop();

// Reverserer animasjon
controller.reverse();

// Resetter animasjon
controller.reset();

// Gjentar animasjon
controller.repeat();

// Animerer til spesifikt punkt
controller.animateTo(0.5);
```

---

# Avvent animasjoner

```dart
// Initiell verdi
print(controller.value); // 0.0

// Start og la gå til slutten
controller.forward().then(() => print(controller.value)); // 1.0
```

---

# Eller lytt til oppdateringer

```dart
controller.addListener(() => print(controller.value));

controller.addStatusListener((status) => print(status));

controller.forward();
// 0.1833 .. 0.78333 .. 1.0
// AnimationStatus.forward .. AnimationStatus.completed
```

---

# Animasjoner i widgets

```dart
@override
Widget build(BuildContext context) {
  return AnimatedBuilder(
    animation: controller,
    builder: (context, child) {
      return Transform.rotate(
        angle: controller.value * 2.0 * 3.14,
        child: child,
      );
    },
    child: Text('Wee!'),
  );
}
```

---

# Animerte widgets

```dart
@override
Widget build(BuildContext context) {
  return AnimatedOpacity(
    duration: Duration(seconds: 1),
    opacity: someValue ? 0 : 1,
    child: Text('Now you see me'),
  );
}
```

---

# Øvelse

I repoet ligger en demo-app som for øyeblikket er ganske kjedelig og trenger litt "spice". Finn interaksjoner, overganger og elementer som kan gjøres mer spennende med animasjoner, og forsøk å bruke både implisitte, eksplisitte og eksterne animasjoner til å gi appen et nytt liv! Ta gjerne inspirasjon fra `example`-prosjektet.
