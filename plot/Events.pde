
void controlEvent(ControlEvent theEvent) {
  /* events triggered by controllers are automatically forwarded to 
   the controlEvent method. by checking the name of a controller one can 
   distinguish which of the controllers has been changed.
   */

  /* check if the event is from a controller otherwise you'll get an error
   when clicking other interface elements like Radiobutton that don't support
   the controller() methods
   */

  if (theEvent.isController()) { 

    //print("control event from : "+theEvent.getController().getName());
    //println(", value : "+theEvent.getController().getValue());

    //if(theEvent.getController().getName()=="bang1") {
    //  colors[0] = colors[0] + color(40,40,0);
    //  if(colors[0]>255) colors[0] = color(40,40,0);    
    //}

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

    //if (theEvent.getController().getName()=="toggle1") {
    //  if (theEvent.getController().getValue()==1) colors[2] = color(0, 255, 255);
    //  else                                 colors[2] = color(0, 0, 0);
    //}

    if (theEvent.getController().getName()=="courbe") {

      if (machineState==SCREEN_2) {
        machineState=SCREEN_1;
        setFieldVisible(true);
      } else {
        machineState=SCREEN_2;
        setFieldVisible(false);
      }
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
    if (theEvent.getController().getName()=="Valeur tension (mV) ?") {
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
  }
}




//// change the trigger event, by default it is PRESSED.
//  controlP5.addBang("bang",40,250,120,40).setTriggerEvent(Bang.RELEASE);
//  controlP5.getController("bang").setLabel("changeMYBackground");
//}


//public void bang() {
//  int theColor = (int)random(255);
//  myColorBackground = color(theColor);
//  println("### bang(). a bang event. setting background to "+theColor);
//}
