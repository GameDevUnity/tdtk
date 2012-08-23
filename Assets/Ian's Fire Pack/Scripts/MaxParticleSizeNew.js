var maxSize : float = 20;
function Update () {
	var particles = particleEmitter.particles;
	for(i = 0; i < particleEmitter.particleCount; i ++){
		if(particles[i].size > maxSize){
			particles[i].size = maxSize;
		}
	}
	particleEmitter.particles = particles;
}