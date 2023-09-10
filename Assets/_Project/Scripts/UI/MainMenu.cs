using System.Collections;
using UnityEngine;
using UserInterface.FX.Image;

public class MainMenu : MonoBehaviour
{
    [SerializeField, Range(0, 10)] private float auto, delay;
    [SerializeField] private GameObject fade;

    //private Controls controls;
    private bool complete;

    #region Input System
    //private void Awake()
    //{
    //    controls = new Controls();
    //    controls.UI.Touch.performed += ctx =>
    //    {
    //        if (!complete)
    //        {
    //            LeanTween.cancelAll();
    //            StartCoroutine(ChangeScene());
    //        }
    //    };
    //}
    //private void OnEnable() => controls.Enable();
    //private void OnDisable() => controls.Disable();
    #endregion

    private IEnumerator Start()
    {
        yield return new WaitForEndOfFrame();
        ImageEvent.Begin();

        //yield return new WaitForSeconds(auto);
        //if (!complete) StartCoroutine(ChangeScene());
    }
    public void Button()
    {
        if (complete) return;
        
        LeanTween.cancelAll();
        StartCoroutine(ChangeScene());
    }
    private IEnumerator ChangeScene()
    {
        complete = true;
        ImageEvent.End();
        //StopCoroutine(Start());
        yield return new WaitForSeconds(delay);

        Instantiate(fade, transform).GetComponent<Fade>().SetScene = Scenes.AR;
    }
}