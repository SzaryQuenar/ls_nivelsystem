class NiwelacjaService {

  double obliczOsCelowa(
    double rzednaRepera,
    double odczytWstecz,
  ) {
    return rzednaRepera + odczytWstecz;
  }

  double obliczRzednaPunktu(
    double osCelowa,
    double odczyt,
  ) {
    return osCelowa - odczyt;
  }

  double obliczReper(
    double osCelowa,
    double odczytWPrzod,
  ) {
    return osCelowa - odczytWPrzod;
  }
}