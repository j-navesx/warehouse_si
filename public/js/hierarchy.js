


/* global tempBtVector */

function add_child(threeParent, threeChild) {
    if (typeof threeParent.userData.children == 'undefined' || threeParent.userData.children === null) {
        threeParent.userData.children = new Array();
        //alert('aaa');
    }
    threeParent.userData.children[threeChild.userData.name] = threeChild;
    threeChild.userData.parent = threeParent
    threeChild.userData.offset_X = threeChild.position.x - threeParent.position.x;
    threeChild.userData.offset_Y = threeChild.position.y - threeParent.position.y;
    threeChild.userData.offset_Z = threeChild.position.z - threeParent.position.z;
    //alert(threeParent.userData.name + ' ---> ' +  threeChild.userData.name);
   // console.log(threeParent.userData.children);
}


function delete_child(threeParent, threeChild) {
    threeParent.userData.children[threeChild.userData.name]=null;
    delete threeParent.userData.children[threeChild.userData.name];
}





function move_delta_linear(threeObject, delta_x, delta_y, delta_z) {

    var x = parseFloat(threeObject.position.x);
    var y = parseFloat(threeObject.position.y);
    var z = parseFloat(threeObject.position.z);

    if (isNaN(threeObject.position.x)) {
        x = 0;
    }

    if (isNaN(threeObject.position.y)) {
        y = 0;
    }

    if (isNaN(threeObject.position.z)) {
        z = 0;
    }

    threeObject.position.x = x + parseFloat(delta_x);
    threeObject.position.y = y + parseFloat(delta_y);
    threeObject.position.z = z + parseFloat(delta_z);
    
    

    /*
    if (isNaN(threeObject.position.x)) {
        debugger;
    }
    */


    // verificar se é só igual
    /*
    threeObject.rotation.x += 0;
    threeObject.rotation.y += 0;
    threeObject.rotation.z += 0;
    */

    var objPhys = threeObject.userData.physicsBody;
    var tr = objPhys.getWorldTransform();
   // tr.setOrigin(new Ammo.btVector3(threeObject.position.x, threeObject.position.y, threeObject.position.z));
   
    tempBtVector.setValue(threeObject.position.x,threeObject.position.y,threeObject.position.z);
    
    tr.setOrigin(tempBtVector);
 //   tr.set

    var children = threeObject.userData.children;
    if (typeof children !== 'undefined' && children !== null) {
        for (var threeName in children)
        {
            if (children.hasOwnProperty(threeName)) 
              //alert("Key is " + threeName + ", value is " + children[threeName]);
                move_delta_linear(children[threeName], delta_x, delta_y, delta_z);
        }
    }
}



function move_abs_linear(threeObject, abs_x, abs_y, abs_z) {
    var x = parseFloat(threeObject.position.x);
    var y = parseFloat(threeObject.position.y);
    var z = parseFloat(threeObject.position.z);

    if (isNaN(threeObject.position.x)) {
        x = 0;
    }

    if (isNaN(threeObject.position.y)) {
        y = 0;
    }

    if (isNaN(threeObject.position.z)) {
        z = 0;
    }

    var delta_x = parseFloat(abs_x) - x;
    var delta_y = parseFloat(abs_y) - y;
    var delta_z = parseFloat(abs_z) - z;
    move_delta_linear(threeObject, delta_x, delta_y, delta_z);
}


function toBinary(val) {
    result = "";
    for (i = 7 ; i >= 0; i--) {
        if ((val & (1 << i)) != 0)
            result += "1";
        else
            result += "0";
        if (i == 4)
            result += " ";
    }
    return (result);
}




function include_html(idFile) {
    $(function () {
        $("#"+idFile).load(idFile+".html#"+ (Math.random()*1000) );
    });
}