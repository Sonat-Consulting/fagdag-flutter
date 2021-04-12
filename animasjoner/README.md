# Animasjoner

Animasjoner og bevegelse i et brukergrensesnitt bidrar til kommunikasjon og "det lille ekstra" som hever oppfattet kvalitet av en app, om brukt med omhu.

## Byggeklosser i Flutter

Flutter har et eget bibliotek for å lage og håndtere animasjoner. Noen grunnleggende klasser i biblioteket er;

- [Animation](https://api.flutter.dev/flutter/animation/Animation-class.html) - holder en gjeldende state for en animasjon, som f.eks. om den er startet, stoppet, går fremover eller bakover, men vet ikke om hva som skjer på skjermen.

- [AnimationController](https://api.flutter.dev/flutter/animation/AnimationController-class.html) - håndterer en `Animation` og brukes til å f.eks. starte, stoppe eller reversere en animasjon.

- [Tween](https://api.flutter.dev/flutter/animation/Tween-class.html) - interpolerer mellom datapunkter og lager mapping mellom en input range og en output range. Ofte brukt med tall, f.eks. fra 0 til 1, men kan også brukes med f.eks. farger (se [ColorTween](https://api.flutter.dev/flutter/animation/ColorTween-class.html)).

Alle animasjoner i Flutter arver fra `Listenable`, og vi kan lytte til enhver endring i staten til en animasjon, f.eks. når den har startet eller stoppet.

## Implisitte animasjoner

En fellesbetegnelse for widgets som håndterer animasjoner for deg. Med implisitte animasjoner kan man animere en property ved å sette en verdi. Når verdien endres, vil widgeten animere fra en forrige verdien til den nye. På denne måten er implisitte animasjoner en tradeoff mellom kontroll og convenience -- de håndterer animasjoner slik at du ikke trenger å gjøre det.

Flutter har flere slike widgets inkludert, men man kan også lage sine egne ved å implementere `ImplicitlyAnimatedWidget`. Eksempler på widgets som er implisitt animert:

- [AnimatedOpacity](https://api.flutter.dev/flutter/widgets/AnimatedOpacity-class.html) - tar parameterne `opacity` og `duration` og animerer synligheten automatisk når `opacity` endres.

- [AnimatedContainer](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html) - tar alle parametre som en vanlig `Container` men animerer alle endringer i verdiene automatisk.

Kodeeksempel for å animere "fade-in" og "fade-out":

```dart
  /*...*/
  double opacity = 1.0;
  Duration duration = Duration(seconds: 1);

  void toggle() {
    setState(() {
      opacity = 1 - opacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: opacity,
          duration: duration,
          child: Text('Now you see me'),
        ),
        ElevatedButton(
          onPressed: toggle,
          child: Text('Toggle'),
        )
      ],
    );
  }
}
```

## Eksplisitte animasjoner

Eksplisitte animasjoner krever mer kode fra oss, men gir oss også en langt større kontroll over animasjonene og hvilke deler av widget-treet som skal gjenbygges under en animasjon.

I bunnen av eksplisitte animasjoner ligger [AnimationController](https://api.flutter.dev/flutter/animation/AnimationController-class.html) som håndterer alt fra å definere animasjoner, generere verdier for animasjoner (interpolasjon), registrere lyttere og kontrollere avspilling/sekvenser. Denne tar seg også av å synkronisere animasjoner til skjermen til enheten. By default arver denne bare fra `Animation` med en range fra 0.0 til 1.0.

For å instansiere en `AnimationController` trenger vi parametrene `vsync` og `duration`.

```dart
final controller = AnimationController(
    vsync: this, // Binding mot enhetens skjerm for frame-synk
    duration: Duration(seconds: 1),
);
```

For å starte en animasjon kaller vi `forward()`:

```dart
controller.forward();
// Starte fra et spesifikt punkt
controller.forward(from: 0.2);
```

Vi kan også legge til lyttere:

```dart
// For alle oppdateringer
controller.addListener(() {
    print(controller.value);
});
// For oppdatering i status (completed, dismissed osv.)
controller.addStatusListener((status) {
    print(status);
});
```

Enn så lenge eksisterer disse animasjonene kun i minnet, og har ingen relasjon til hva som blir tegnet på skjermen. Det den derimot har, er en relasjon til skjermens oppdateringssyklus gjennom `vsync`-parameteret. For å få takk i denne bindingen, må vi inkludere en "mixin" til klassen vår:

```dart
class _ExampleState extends State with TickerProviderStateMixin {}
```

Nå som vi har en instans av `AnimationController` koblet opp mot skjermens "tickrate" kan vi koble animasjonen til en widget. Siden kontrolleren vår ikke har en relasjon til hva som blir tegnet, må vi ha en måte å gjen-tegne skjermen etterhvert som animasjonen går fremover. Den naive måten er da å kalle `setState()`, som tvinger en rebuild:

```dart
controller.addListener(() => setState(() {}));
```

Det fungerer, men problemet med denne fremgangsmåten er at hele widget-treet i `build`-metoden blir rebuildet for hver oppdatering i animasjonen. Ikke et stort problem om man har et kort tre med få widgets, men kan ha stor påvirkning dersom man f.eks. rebuilder høyt oppe i treet. Flutter har derfor en widget kalt [AnimatedBuilder](https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html) som lar oss kun rebuilde subtreet som skal rebuildes:

```dart
@override
Widget build(BuildContext context) {
  return AnimatedBuilder(
    animation: controller,
    // Dette treet blir ikke rebuildet når animasjonen spilles av
    child: Center(
      child: Text('Whee!'),
    ),
    builder: (BuildContext context, Widget? child) {
      return Transform.rotate(
          angle: _controller.value * 2.0 * 3.14,
          child: child,
      );
    },
  );
}
```
