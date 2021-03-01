  const initEdit = () => {
    const button = document.querySelector('#edit');

    if (button) {
      button.addEventListener('click', editField);
    }
  }


  const editField = (event) => {
    event.preventDefault();
    document.querySelector('.address-view').style.border = 'solid 2px black';
    document.querySelector('#edit').style.display = 'none';
    document.querySelector('#save').style.display = 'block';
    document.querySelector('#editable').style.display = 'block';
    //document.querySelector('.address-view__text').contentEditable = 'true';
    const editAddress =document.querySelector('.address-view__text1');


  }

  const saveField = (event) => {
    event.preventDefault();
    document.querySelector('.address-view').style.border = 'solid 2px black';


  }


  export { initEdit };
