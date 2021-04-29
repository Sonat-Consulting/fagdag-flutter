# Oppgave 3 - Platform channels

Denne oppgaven gir en innføring i platform channels, som er måten å kommunisere med plattform-spesifikk kode.
I de fleste tilfeller er ikke dette nødvendig, da det allerede finnes pakker for det meste.
Men i enkelte tilfeller trenger man tilgang til native funksjonalitet som ikke allerede er implementert i flutter,
eller man ønsker å ta i bruk eksisterende plattform-spesifikk kode/biblioteker.

## Oppsett

For denne øvelsen fokuseres det på Android, og man må derfor sette opp en Android-emulator.
Guide for dette finner du her: https://developer.android.com/studio/run/managing-avds#createavd

## Utgangspunkt

Vi tar utgangspunkt i sample-prosjektet som du får ved å opprette et nytt prosjekt.
I Android Studio er dette File -> New -> New Flutter Project,
evt du kan kjøre kommandoen `flutter create platform_channel_demo`.
Åpne prosjektet i IDEen din og sjekk at du får kjørt det på emulatoren.

## Opprette en MethodChannel i Flutter
Definér en MethodChannel i _MyHomePageState:
```
static const platform = const MethodChannel('no.sonat.demo/native');
```
Kanalnavnet må være unikt, dersom man har flere kanaler i samme app eller bruker biblioteker som bruker platform channels.
Det anbefales også å prefikse kanalnavnet med et domene slik som over.

## Sette batteristatus
Bytt ut `_counter` med noe som kan holde på batteristatusen:
```
String _batteryLevel = 'Unknown';
```
Bytt så ut metoden `_incrementCounter` med en metode for å hente batteristatus fra en metode i platform channel
```
  void _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = result.toString();
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    } on Exception catch (e) {
      batteryLevel = "Unexpected exception: ${e.toString()}";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
```
Ved å oppdatere `_batteryLevel` inni `setState` sørger vi for at viewet blir oppdatert med den nye verdien

## Oppdatere build-metoden til å vise resultatet
* Endre tittelteksten til f.eks. 'Battery level is:'
* Endre slik at verdien hentes fra `_batteryLevel` i stedet for `_counter`
* Endre knappen til å være en `ElevatedButton`, med en fornuftig tekst, og sørg for at den kaller riktig funksjon.
* Kjør appen, og se hva som skjer når knappen trykkes

## Lag plattform-implementasjonen i Android
* Åpne under-prosjektet `android` i et nytt vindu
* Finn MainActivity
* Overstyr metoden `configureFlutterEngine`, sett opp en handler for kanalen vi definerte i Flutter,
og håndter kall til `getBatteryLevel`
```
    private val CHANNEL = "no.sonat.demo/native"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when(call.method) {
                "getBatteryLevel" -> {
                    getBatteryLevel().takeIf { it != -1 }?.let {
                        result.success(it)
                    } ?: result.error("UNAVAILABLE", "Battery level not available.", null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        with(getSystemService(Context.BATTERY_SERVICE) as BatteryManager) {
            return getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        }
    }
```
* Oppdater `minSdkVersion` i `build.gradle` til 21 for å unngå å håndtere eldre Android-versjoner
* Kjør appen fra android-prosjektet
* Du kan endre batterinivå i innstillingene på emulatoren for å teste

## Ekstra
* Legg til en ny funksjon, som f.eks. henter OS-versjonen


