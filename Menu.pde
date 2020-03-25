Group createDiseaseMenu() {
  Group diseaseMenu = cp5.addGroup("diseaseMenu")
    .setPosition(width/2 - width/2/2, height/2 - height/1.8/2)
    .setWidth(width/2)
    .activateEvent(true)
    .setBackgroundColor(color(25))
    .setBackgroundHeight((int)(height/1.8))
    .setTitle("COVID Inc.")
    .disableCollapse();
    //.hideBar();
    
   //diseaseMenu.getCaptionLabel().setPadding(10, 10);
    
  int diseaseMenuSliderWidth = (int)(diseaseMenu.getWidth()/1.7);

  ControlFont bigFont = new ControlFont(createFont("Arial", 20, true));
  
  cp5.addTextfield("   population")
    .setGroup(diseaseMenu)
    .setPosition(10, 15)
    .setSize(diseaseMenu.getWidth()/4, 20)
    .setAutoClear(false)
    .setText("800")
    .getCaptionLabel().align(ControlP5.RIGHT_OUTSIDE, ControlP5.CENTER);
    
  cp5.addSlider("healthcare capacity")
    .setGroup(diseaseMenu)
    .setPosition(10, 50)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(0, 1)
    .setValue(0.08);
    
  cp5.addSlider("person size")
    .setGroup(diseaseMenu)
    .setPosition(10, 80)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(0.3, 4)
    .setValue(1);
    
  cp5.addSlider("person speed")
    .setGroup(diseaseMenu)
    .setPosition(10, 110)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(3, 20)
    .setValue(7);
    
  cp5.addSlider("recovery duration")
    .setGroup(diseaseMenu)
    .setPosition(10, 140)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(50, 1000)
    .setValue(350);
    
  cp5.addSlider("mortality duration")
    .setGroup(diseaseMenu)
    .setPosition(10, 170)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(50, 1000)
    .setValue(150);
    
  cp5.addSlider("mortality rate")
    .setGroup(diseaseMenu)
    .setPosition(10, 200)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(0, 1)
    .setValue(0.05);
    
  cp5.addSlider("mortality rate without healthcare")
    .setGroup(diseaseMenu)
    .setPosition(10, 230)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(0, 1)
    .setValue(0.2);
    
  cp5.addSlider("chance of infection on contact")
    .setGroup(diseaseMenu)
    .setPosition(10, 260)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(0, 1)
    .setValue(0.8);
    
  cp5.addSlider("social distancing proportion")
    .setGroup(diseaseMenu)
    .setPosition(10, 290)
    .setSize(diseaseMenuSliderWidth, 20)
    .setRange(0, 1)
    .setValue(0.3);
  
  cp5.addButton("infect")
    .setGroup(diseaseMenu)
    .setPosition(diseaseMenu.getWidth()/2 - (diseaseMenu.getWidth() - 20)/2, diseaseMenu.getBackgroundHeight() - 40 - 10)
    .setSize(diseaseMenu.getWidth() - 20, 40)
    .getCaptionLabel().setFont(bigFont);
    
  return diseaseMenu;
}

Disease createDisease(Group menu) {
  Textfield population = (Textfield)(menu.getController("   population"));
  
  return new Disease(
    Integer.parseInt(population.getText()),
    menu.getController("healthcare capacity").getValue(),
    menu.getController("person size").getValue(),
    menu.getController("person speed").getValue(),
    (int)menu.getController("recovery duration").getValue(),
    (int)menu.getController("mortality duration").getValue(),
    menu.getController("mortality rate").getValue(),
    menu.getController("mortality rate without healthcare").getValue(),
    menu.getController("chance of infection on contact").getValue(),
    menu.getController("social distancing proportion").getValue()
  );
}
