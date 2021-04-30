# Observatory

## Oppgave

Vi skal lage en CRUD-applikasjon som bruker et enkelt REST-API til å håndtere en liste med observasjoner vi har gjort. Vi skal kunne opprette, lese, endre og slette observasjoner.

## Oppsett

Vi kjører json-server på baksiden, som kan kjøres opp med

```bash
docker compose up -d
```

og starter på localhost:8082. Dersom du kjører på Android, er APIet tilgjengelig på 10.0.2.2:8082, men om du kjører på en fysisk enhet må du finne maskinens IP for å kunne koble til (endres i `lib/repositories/observation_repository.dart`).

## Oppgave 1

Legg til et kall i `onRefresh` som oppdaterer dataene i listen.

## Oppgave 2

Implementer oppretting av observasjon og navigasjon tilbake til listen.

## Oppgave 3

Legg til et PUT-kall for å oppdatere en gitt observasjon.

## Oppgave 4

Implementer sletting og oppdatering fra detalj-siden.
