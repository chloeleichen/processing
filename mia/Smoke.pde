class Smoke {
PVector p, pOld;
float noiseZ, noiseZVelocity = 0.01;
float stepSize, angle;

float theta = random(0, 0.5*PI);
float disX;
float disY;

Smoke() {
p = new PVector(0, 0);
pOld = new PVector(p.x,p.y);
stepSize = random(1,5);
// init noiseZ
setNoiseZRange(0.4);

}

void update(PVector hand){
angle = noise(p.x/noiseScale, p.y/noiseScale, noiseZ) * noiseStrength;

p.x += cos(angle) * stepSize;
p.y += sin(angle) * stepSize;

if ((p.y<0)||(p.x<0)) {
p.y=pOld.y= hand.y-r;
p.x=pOld.x= hand.x-r;
}
if ((p.y>height) || (p.x>width)){
p.y=pOld.y=hand.y-r;
p.x=pOld.x=hand.x-r;
}

strokeWeight(strokeWidth*stepSize);
line(pOld.x,pOld.y, p.x,p.y);

pOld.set(p);
noiseZ += noiseZVelocity;

}

void setNoiseZRange(float theNoiseZRange) {
// small values will increase grouping of the fumes
noiseZ = random(theNoiseZRange);
}
}
