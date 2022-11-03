using UnityEngine;
using System.Collections;
using UnityEditor;

public class WeatherController : MonoBehaviour {
    public static WeatherController instance;
    public Camera targetCamera;


    [Header("Calculate fog & rain from clouds value?")]

    public bool automaticFog;
    public bool automaticRain;

    [Range(0, 100)]
    public float clouds;
    [Range(0, 100)]
    public float fog;
    [Range(0, 100)]
    public float rain;

    [Range(0, 2400)]
    public float time;
    public float timeSpeed;
    public float windSpeed;
    public bool snowing;

    public AnimationCurve sunlightIntensityCurve;
    public AnimationCurve moonlightIntensityCurve;
    public AnimationCurve cloudIntensityCurve;
    public GameObject sunObject;
	public GameObject moonObject;
	public GameObject cloudsOvercastObject;
	public GameObject cloudsSmallObject;
	public GameObject particlesObject;
	public ParticleSystem rainParticles;
	public AudioSource rainAudio;
	private ParticleSystem.EmissionModule rainEmission;
	public ParticleSystem snowParticles;
	private ParticleSystem.EmissionModule snowEmission;
	public Renderer cloudsOvercastMaterial;
	public Renderer cloudsSmallMaterial;
    public Light sunLight;
    public Light moonLight;
    public Gradient fogColorGradient;
	public Color skyColor;
	public Gradient lightColor;
    public Gradient ambientColor;
    public Transform sphere;

    private void Awake() {
        instance = this;
    }
    void Start () {

		rainEmission = rainParticles.emission;
		snowEmission = snowParticles.emission;

        RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Flat;
        RenderSettings.fog = true;
        RenderSettings.fogMode = FogMode.Linear;
        RenderSettings.fogEndDistance = 175;
        if (targetCamera == null) { 
            Debug.LogError("Camera not found! Please assign your main camera as the Target Camera in the WeatherController script.");
        }
        targetCamera.clearFlags = CameraClearFlags.SolidColor;
	}


	void Update () {
		sphere.position = targetCamera.transform.position;
		updateLights();
		updateTime();
		updateClouds();
		updateFog();
        UpdateRain();
        UpdateAmbientColor();
	}
    void UpdateAmbientColor() {
        RenderSettings.ambientSkyColor = ambientColor.Evaluate(time / 2400f);
    }
		

	void updateClouds(){
		if(clouds>50){
            float lightCurve = cloudIntensityCurve.Evaluate(time / 2400f);
            cloudsOvercastMaterial.material.SetColor("_TintColor", new Color(lightCurve, lightCurve, lightCurve, (clouds - 50) / 50f));
            //cloudsOvercastMaterial.material.SetColor("_TintColor", Color.Lerp(c, new Color(c.r, c.g, c.b, (cloudiness-50)/50f), 0.1f*Time.deltaTime));

            cloudsSmallMaterial.material.SetColor("_TintColor", new Color(lightCurve, lightCurve, lightCurve, 1));
        } else{

            float lightCurve = cloudIntensityCurve.Evaluate(time / 2400f);
            cloudsSmallMaterial.material.SetColor("_TintColor", new Color(lightCurve, lightCurve, lightCurve, (clouds) / 50f));
            //cloudsSmallMaterial.material.SetColor("_TintColor", Color.Lerp(c2, new Color(c2.r, c2.g, c2.b, (cloudiness)/50f), 0.1f*Time.deltaTime));


            Color c = cloudsOvercastMaterial.material.GetColor("_TintColor");
            cloudsOvercastMaterial.material.SetColor("_TintColor", new Color(lightCurve, lightCurve, lightCurve, 0));
        }
		cloudsSmallObject.transform.rotation = Quaternion.Euler(-90, cloudsSmallObject.transform.eulerAngles.y+windSpeed*Time.deltaTime, 0);
		cloudsOvercastObject.transform.rotation = Quaternion.Euler(-90, cloudsOvercastObject.transform.eulerAngles.y+windSpeed*Time.deltaTime, 0);

	}
    void UpdateRain() {
        if(automaticRain)
        rain = clouds;

        particlesObject.transform.position = targetCamera.transform.position + new Vector3(0, 0, 0);
        if (rain > 80 && snowing==false) {
            rainEmission.rateOverTime = Mathf.Lerp(rainParticles.emission.rateOverTime.constant, ((rain - 80) / 20f) * 1000f, 0.1f * Time.deltaTime);
            snowEmission.rateOverTime = Mathf.Lerp(snowParticles.emission.rateOverTime.constant, 0, 0.1f * Time.deltaTime);
        } else {
            if (snowing && rain > 80) {
                snowEmission.rateOverTime = Mathf.Lerp(snowParticles.emission.rateOverTime.constant, ((rain - 80) / 20f) * 200f, 0.1f * Time.deltaTime);
            } else {
                snowEmission.rateOverTime = Mathf.Lerp(snowParticles.emission.rateOverTime.constant, 0, 0.1f * Time.deltaTime);
            }
            rainEmission.rateOverTime = Mathf.Lerp(rainParticles.emission.rateOverTime.constant, 0f, 0.1f * Time.deltaTime);
        }
        rainAudio.volume = (rainEmission.rateOverTime.constant / 1000f);
    }

	void updateTime(){
		time+=timeSpeed*Time.deltaTime;
		if(time>2400)time=0;
	}
	void updateFog(){

        if (automaticFog)
            fog = clouds;

        Color color = fogColorGradient.Evaluate(time / 2400f);
        Color newColor = Color.Lerp(color, new Color(0.25f, 0.25f, 0.25f), fog/100f);
        RenderSettings.fogColor = newColor; // set current fog color from gradient
        targetCamera.backgroundColor = newColor;
        RenderSettings.fogStartDistance = 100 - 250 * (fog / 100f);
	}
	void updateLights(){
		sunObject.transform.rotation = Quaternion.Euler(new Vector3((time/2400f)*360+180+50, (time / 2400f)*180, 0));
		moonObject.transform.rotation = Quaternion.Euler(new Vector3((time/2400f)*360+50, 0, 0));
        moonLight.intensity = moonlightIntensityCurve.Evaluate(time / 2400f);
        sunLight.intensity = sunlightIntensityCurve.Evaluate(time/2400f);
		sunLight.intensity -= 0.7f * (clouds/100f); // reduce light intensity when it's cloudy, max 0.3 intensity when raining hard
		sunLight.color = lightColor.Evaluate(time/2400f);
	}



    
}