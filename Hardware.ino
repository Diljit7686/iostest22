// This #include statement was automatically added by the Particle IDE.
#include <InternetButton.h>
InternetButton button = InternetButton();
void setup() {
button.begin();
Particle.function("controlLights", controlLights);

}

void loop()
{

if (button.buttonOn(4)) {


button.allLedsOn(0,255,0);

delay(3000);
button.allLedsOn(102,255,102);



delay(3000);
button.allLedsOn(255,255,110);

delay(3000);



button.allLedsOn(255,255,0);
delay(3000);

button.allLedsOn(255,128,0);



delay(8000);


button.allLedsOn(255,0,0);

Particle.publish("playerChoice","A", 60, PRIVATE);




}
if (button.buttonOn(2)) {

// publish a message to the Internet!
Particle.publish("playerChoice","B", 60, PRIVATE);
button.allLedsOff();

}

}



int controlLights(String cmd) {

if(cmd == "start"){
button.allLedsOn(0,255,0);

delay(3000);
button.allLedsOn(102,255,102);



delay(3000);
button.allLedsOn(255,255,110);

delay(3000);



button.allLedsOn(255,255,0);
delay(3000);

button.allLedsOn(255,128,0);



delay(8000);


button.allLedsOn(255,0,0);



}
else if(cmd == "off")
{
button.allLedsOff();
}




}





