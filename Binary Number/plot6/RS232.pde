import processing.serial.*;

Serial portSerie;

// contrôles visuels pour la partie liaison série
ScrollableList listePortSerie;
Toggle togMessage;

void initIHMSerie()
{
  // création des widgets permettant le choix de la liaison série
  listePortSerie = cp5.addScrollableList("Choisir Port Serie")
    .setPosition(20, 20)
    .setSize(130, 40)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(Serial.list())
    .close()
    ;

  // sélection du premier port série disponible
  if (Serial.list().length > 0)
    listePortSerie.setValue(1);
  // si aucun port série dispo -> big pb !
  else
  {
    System.err.println("************** Aucun port série trouvé !! **************");
    System.err.println("***** L'éxécution du programme semble compromise ! *****");
  }

  cp5.addButton("OuvrirPortSerie")
    .setLabel("Ouvrir le port Serie")
    .setPosition(160, 20)
    .setSize(115, 20)
    ;

  cp5.addButton("FermerPortSerie")
    .setLabel("Fermer le port Serie")
    .setPosition(285, 20)
    .setSize(115, 20)
    ;
}

void OuvrirPortSerie()
{
  if (portSerie == null)
  {
    String nomPortSerie = listePortSerie.getItem(int(listePortSerie.getValue())).get("name").toString();
    tDebug.append("Tentative d'ouverture du port Série : " + nomPortSerie + " ... ");
    portSerie = new Serial(this, nomPortSerie, 9600);
    // bufferuntil permet de lancer la fonction SerialEvent lorsqu'un caractère apparait (ici '\n' de valeur 10)
    portSerie.bufferUntil(10);

    if (portSerie == null)
    {
      tDebug.append("Le port série n'est pas ouvert ! Un problème est survenu !\n");
    } else
    {
      tDebug.append(" Ça a marché !\n");
      adc=0; 
      tension=0;
      cp5.get(Slider.class, "Tension (milliV)").setValue(0);
    }
  } else
    tDebug.append("Port Série déjà ouvert !\n");
}

void FermerPortSerie()
{
  if (portSerie != null)
  {
    portSerie.stop();
    portSerie = null;
    tDebug.append("Port Série fermé !\n");
  } else
    tDebug.append("Port Série déjà fermé !\n");
}

// la fonction serialEvent est lancée de manière automatique lors de la venue d'un caractère '\n' (voir bufferUntil plus haut)
void serialEvent(Serial p)
{
  // lecture du message
  String messageRecep="";
  String[] list; // à declarer ici sinon pb

  messageRecep = p.readStringUntil ('\n'); 

  if (messageRecep != null) { 
    tDebug.clear();
    tDebug.append("Trame reçue => "+messageRecep);
    list = split(messageRecep, ':');
    println(list.length);
    if(list.length < 4) return;
 
    if (trim(list[0]).equals("CAN") == true) trameN = trim(list[1]);
    else trameN="0";

    if (trim(list[2]).equals("Tension (mV)") == true) trameV = trim(list[3]);
    else trameV="0";
    //println("\t"+trameN);

    adcOK=true;
    //xPos = Integer.parseInt(list[0]);
    //yPos = Integer.parseInt(list[1]); //10*Float.valueOf(list[1]).floatValue();
    //currentValue = map(currentValue, 0, 1023, 0, height);
  }
}
