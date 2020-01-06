
///

void drawFrame(int spacer) { 

  for (int y = 0; y < height-20; y += spacer) {
    for (int x = 20; x < width; x += spacer) {
      stroke(2);
      fill(0,255,0);
      strokeWeight(2);
      point(x + spacer/2, y + spacer/2);
    }
  }
}

///
// start : N de départ (ordonnée)
// spacer: nombre de points  (ex pour 30 points (echelle) 30*20 =600 = width
void drawCurve (int start, int spacer) {
  int j=0; // pour les points rouges

  for (int i = 0+start; i < 600; i++) {

    int nb=1;  // granularity : for test case

    // calcul des x, y du point considéré
    int x1=j + (nb+2)*spacer/2;   // nb+2 pour décaler vs echelle des ordonnées
    int y1=height -(j + (nb+2)*spacer/2);

    // affichage des segments
    strokeWeight(1);
    stroke(0, 100, 255);
    if (i!=start) line(x1, y1, x1, y1+nb*spacer);   // ne pas tracer si c'est le premier point (défini par start)
    if (i!=start)line(x1, y1+nb*spacer, x1-nb*spacer, y1+nb*spacer);

    // affichage des points de la courbe 
    strokeWeight(6);
    stroke(255, 0, 0);
    point(x1, y1);
       
    
    strokeWeight(1);  // IMPORTANT POUR EVITER EFFET DE BORD

    //affichage valeurs
    //// ordonnées
    fill(0);
    textAlign(CENTER);
    textSize(7);
    String s = Integer.toBinaryString(j/spacer+start);
    text(""+s, 20, y1);  
    //// abscisses
    text(""+floor(i*5), x1, height-12); // affichage avec vraie valeur  (à chnager le 5 par LSB et voir impact sur screen default!!!!!!)
    // affichage en formule avec q
    //text(""+i, x1, height-12); 
    //text("xq", x1, height-6);

    // next item
    j = j + spacer;  // en fin de bloc, important sinon j=0 ne sera jamais traité
    
  }
}
