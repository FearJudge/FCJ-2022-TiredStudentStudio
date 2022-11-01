using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarryableObject : MonoBehaviour, ICarryable
{
    bool _carried = false;
    Transform _senpai;
    Vector3 _carryOffset;
    Rigidbody _rigidbody;

    private void Awake()
    {
        _rigidbody = GetComponent<Rigidbody>();
    }

    public bool AmICarryable()
    {
        return !_carried;
    }

    public void ReleaseCarriedState()
    {
        _carried = false;
        if (_rigidbody != null) { _rigidbody.isKinematic = false; }
    }

    public void SetCarriedState(Transform toAttachTo, Vector3 offset = default)
    {
        _carried = true;
        _senpai = toAttachTo;
        _carryOffset = offset;
        if (_rigidbody != null) { _rigidbody.isKinematic = true; }
    }

    // Update is called once per frame
    void Update()
    {
        if (!_carried) { return; }
        transform.position = _senpai.position + _carryOffset;
    }

    public bool AmIInteractable()
    {
        throw new System.NotImplementedException();
    }

    public void Interact()
    {
        throw new System.NotImplementedException();
    }
}

public interface ICarryable : IInteract
{
    bool AmICarryable();
    void SetCarriedState(Transform toAttachTo, Vector3 offset = default);
    void ReleaseCarriedState();
}
