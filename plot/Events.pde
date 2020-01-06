
void controlEvent(ControlEvent theEvent) {


  if (theEvent.isController()) { 

    //print("control event from : "+theEvent.getController().getName());
    //println(", value : "+theEvent.getController().getValue());

    // button
    if (theEvent.getController().getName()=="Plus") {
      if (adc<1024) adc++;
      tension = floor(LSB*adc);
      //println(adc+"  "+tension);
    }

    if (theEvent.getController().getName()=="Moins") {
      if (adc>0) adc--;
      tension = floor(LSB*adc);
      //println(adc+"  "+tension);
    }

    if (theEvent.getController().getName()=="RAZ") {
      adc=0;
      tension = 0;
      razBits();
    }


    // slider 
    if (theEvent.getController().getName()=="Tension (milliV)") {
      tension = theEvent.getController().getValue();
      adc = floor(tension/LSB);
      //setBits(adc);
      //println(floor(tension));
    }

    //if (theEvent.getController().getName()=="knob1") {
    //  colors[5] = color(0, 0, theEvent.getController().getValue());
    //}

    // number box
    if (theEvent.getController().getName()=="quantum (mv)") {
      LSB = theEvent.getController().getValue();
    }


    // number box
    if (theEvent.getController().getName()=="startValue(mV)") {
      startValue = floor( (theEvent.getController().getValue()/LSB));
      //println(startValue);
    }

    // text field
    if (theEvent.getController().getName()=="Valeur décimale ?") {
      String s = trim(theEvent.getStringValue());
      tension = Integer.parseInt(s);
      adc = int (tension/LSB);
    }


    for (int i=0; i<10; i++) {
      if (theEvent.getController().getName().equals("   b"+i)) {
        if (theEvent.getController().getValue()==1) adc+=pow(2, i);
        else adc-=pow(2, i);
        if (adc<0) adc=0;
        tension = adc*LSB;
        //if (theEvent.getController().getLabel()=="0") theEvent.getController().setLabel("1");
        //else theEvent.getController().setLabel("0");
        //if (theEvent.getController().getId()==i) adc+=pow(i,2);
      }
    }
  } //if (theEvent.isController()) { 

  if (theEvent.isTab()) {
    machineState = theEvent.getTab().getId();
  }
}
