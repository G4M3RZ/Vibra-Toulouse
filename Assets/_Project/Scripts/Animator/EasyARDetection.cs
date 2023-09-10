using UnityEngine;
using UnityEngine.Events;
using easyar;

public class EasyARDetection : MonoBehaviour
{
    [SerializeField] private ImageTargetController image;
    [SerializeField] private UnityEvent onActive, onDesactive;

    private void Awake()
    {
        image.TargetFound += () => onActive.Invoke();
        image.TargetLost += () => onDesactive.Invoke();
    }
}