function createGraph() {

    if (!Detector.webgl) Detector.addGetWebGLMessage();
    var clock = new THREE.Clock();
    // var SCREEN_HEIGHT = window.innerHeight;
    // var SCREEN_WIDTH = window.innerWidth;
    var SCREEN_HEIGHT = 450;
    var SCREEN_WIDTH = 720;
    // var stats, info = $('#barName');
    var camera, scene, projector, renderer, light, ambientLight;
    var grid = [];
    var paused = false;
    var down = false;
    var sx = 0, sy = 0;
    var rot = Math.PI / 3;
    var max = 0;
    var running = 0;
    var dynamicHeight = {y:1};
    var mouse = { x:0, y:0 }, INTERSECTED, INTERSECTED_CLICK;

    THREE.LeftAlign = 1;
    THREE.CenterAlign = 0;
    THREE.RightAlign = -1;
    THREE.TopAlign = -1;
    THREE.BottomAlign = 1;

    init();
    animate();

    function init() {
        renderer = new THREE.WebGLRenderer({antialias:true});
        renderer.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
        // document.body.appendChild(renderer.domElement);
        document.getElementById("graph-canvas").appendChild(renderer.domElement);
        //Stat Bar
        // stats = new Stats();
        // stats.domElement.style.position = 'absolute';
        // stats.domElement.style.top = '70px';
        // // document.body.appendChild(stats.domElement);
        // document.getElementById("graph-canvas").appendChild(renderer.domElement);


        renderer.shadowMapEnabled = true;
        renderer.shadowMapSoft = true;
        renderer.shadowMapWidth = 1024;
        renderer.shadowMapHeight = 1024;
        renderer.shadowCameraFov = 35;

        scene = new THREE.Scene();

        camera = new THREE.PerspectiveCamera(45, SCREEN_WIDTH / SCREEN_HEIGHT, 1, 10000);
        camera.position.y = 150;
        camera.position.x = Math.cos(rot) * 170;
        camera.position.z = Math.sin(rot) * 170;
        scene.add(camera);

        light = new THREE.SpotLight();
        light.castShadow = true;
        light.position.set(-170, 300, 100);
        scene.add(light);

        ambientLight = new THREE.PointLight(0xFFFFFF);
        ambientLight.position.set(20, 150, -120);
        scene.add(ambientLight);

        var plane = new THREE.Mesh(
                new THREE.CubeGeometry(200, 20, 200),
                new THREE.MeshPhongMaterial({color:0xFFFFFF}));
        plane.position.y = -10;
        plane.receiveShadow = true;
        plane.doubleSided = true;
        plane.name = 'Plane';
        scene.add(plane);

        dynamicHeight.y = 1;
        var x_drawn = false;
        var length = {x:10, y:10};
        //todo: this is cheating. You'll need to find a max if you want to use real data.
        max = ((length.x - 1) * (length.y - 1)) + 5;
        for (var y = 0; y < length.y; y++) {
            drawYLabel(y, length);
            for (var x = 0; x < length.x; x++) {
                grid[running] = [];
                if(x_drawn === false){drawXLabel(x, length);}
                grid[running].height = (x * y) + 5;
                drawBar(y, x, length, grid[running].height);
                running++;
            }
            x_drawn = true;
        }
        renderer.render(scene, camera);
        projector = new THREE.Projector();
        window.addEventListener('resize', onWindowResize, false);
        document.addEventListener('mousemove', onDocumentMouseMove, false);
    }

    function updateBar(j) {
        grid[j].geo.verticesNeedUpdate = true;
        grid[j].geo.vertices[0].y = dynamicHeight.y;
        grid[j].geo.vertices[1].y = dynamicHeight.y;
        grid[j].geo.vertices[4].y = dynamicHeight.y;
        grid[j].geo.vertices[5].y = dynamicHeight.y;
    }

    function completeBar(j) {
        grid[j].done = true;
        grid[j].geo.verticesNeedUpdate = true;
        grid[j].geo.normalsNeedUpdate = true;
        grid[j].geo.computeFaceNormals();
        grid[j].geo.computeBoundingSphere();
        running--;
    }

    function drawBar(y, x, length, height) {
        //Draws the bars
        //Colors are coming out different when set as HSL then
        //converted to HEX.
        var mat = new THREE.MeshPhongMaterial({color:0xFFAA55});
        var color = new THREE.Color();
        color.offsetHSL(0.4 + 0.8 * height / max, 0.85, 1);
        mat.color.setHex(color.getHex());

        grid[running].geo = new THREE.CubeGeometry(8, 2, 8);
        grid[running].geo.dynamic = true;
        grid[running].geo.verticesNeedUpdate = true;
        grid[running].baseColor = color.getHex();

        var mesh = new THREE.Mesh(grid[running].geo, mat);
        mesh.position.x = (x - (length.x - 1) / 2) * 16;
        mesh.position.y = 1;
        mesh.position.z = -(y - (length.y - 1) / 2) * 16;
        mesh.castShadow = mesh.receiveShadow = true;
        mesh.name = grid[running].name = running;
        grid[running].done = false;
        scene.add(mesh);

        var update = partial(updateBar, running);
        var complete = partial(completeBar, running);
        grid[running].tween = new TWEEN.Tween(dynamicHeight)
                .to({y:(height / max * 80)}, 3500)
                .easing(TWEEN.Easing.Elastic.Out)
                .onUpdate(update)
                .onComplete(complete)
                .delay(1000)
                .start();
    }

    function drawYLabel(y, length) {
        //Marks 1-10 on the graph
        var title = alignPlane(createText2D(y + 1), THREE.CenterAlign, THREE.CenterAlign);
        title.scale.set(0.25, 0.25, 0.25);
        title.position.x = (-1 - (length.x - 1) / 2) * 16;
        title.position.z = -(y - (length.y - 1) / 2) * 16;
        title.position.y = 1;
        title.rotation.x = -Math.PI / 2;
        scene.add(title);
    }

    function drawXLabel(x, length) {
        //Marks A-J on the graph
        var c = String.fromCharCode(x + 65);
        var title = alignPlane(createText2D(c), THREE.CenterAlign, THREE.CenterAlign);
        title.scale.set(0.25, 0.25, 0.25);
        title.position.x = (x - (length.x - 1) / 2) * 16;
        title.position.z = -(-1 - (length.y - 1) / 2) * 16;
        title.position.y = 1;
        title.rotation.x = -Math.PI / 2;
        scene.add(title);
    }

    function createTextCanvas(text, color, font, size) {
        size = size || 24;
        var canvas = document.createElement('canvas');
        var ctx = canvas.getContext('2d');
        var fontStr = (size + 'px ') + (font || 'Arial');
        ctx.font = fontStr;
        var w = ctx.measureText(text).width;
        var h = Math.ceil(size * 1.25);
        canvas.width = w;
        canvas.height = h;
        ctx.font = fontStr;
        ctx.fillStyle = color || 'black';
        ctx.fillText(text, 0, size);
        return canvas;
    }

    function createText2D(text, color, font, size, segW, segH) {
        var canvas = createTextCanvas(text, color, font, size);
        var plane = new THREE.PlaneGeometry(canvas.width, canvas.height, segW, segH);
        var tex = new THREE.Texture(canvas);
        tex.needsUpdate = true;
        var planeMat = new THREE.MeshBasicMaterial({
            map:tex, color:0xffffff, transparent:true
        });
        var mesh = new THREE.Mesh(plane, planeMat);
        mesh.doubleSided = true;
        return mesh;
    }

    function alignPlane(plane, horizontalAlign, verticalAlign) {
        var obj = new THREE.Object3D();
        var u = plane.geometry.vertices[0];
        var v = plane.geometry.vertices[plane.geometry.vertices.length - 1];
        var width = Math.abs(u.x - v.x);
        var height = Math.abs(u.y - v.y);
        plane.position.x = (width / 2) * horizontalAlign;
        plane.position.y = (height / 2) * verticalAlign;
        obj.add(plane);
        return obj;
    }

    function onDocumentMouseMove(event) {
        event.preventDefault();
        mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
        mouse.y = -( event.clientY / window.innerHeight ) * 2 + 1;
    }

    document.ondblclick = function () {
        var intersects = findIntersections();
        if (intersects.length > 0) {
            if (INTERSECTED_CLICK != intersects[ 0 ].object && intersects[ 0 ].object.name !== 'Plane') {
                if (INTERSECTED_CLICK) {
                    INTERSECTED_CLICK.material.color.setHex(grid[INTERSECTED_CLICK.name].baseColor);
                }
                INTERSECTED_CLICK = intersects[ 0 ].object;
                INTERSECTED_CLICK.material.color.setHex(0xa854fe);
                INTERSECTED.currentHex = 0xa854fe;
                info.html('Bar #' + INTERSECTED_CLICK.name);
                info.show();
            }
        }
    };

    window.onmousedown = function (ev) {
        down = true;
        sx = ev.clientX;
        sy = ev.clientY;
    };

    window.onmouseup = function () {
        down = false;
    };

    window.onmousemove = function (ev) {
        if (down) {
            var dx = ev.clientX - sx;
            var dy = ev.clientY - sy;
            rot += dx * 0.01;
            camera.position.x = Math.cos(rot) * 170;
            camera.position.z = Math.sin(rot) * 170;
            camera.position.y = Math.max(5, camera.position.y + dy);
            sx += dx;
            sy += dy;
        }
    };

    function animate() {
        window.requestAnimationFrame(animate, renderer.domElement);
        render();
        // stats.update();
    }

    function render() {
        if (!paused) {
            renderer.clear();
            camera.lookAt(scene.position);
            renderer.render(scene, camera);

            TWEEN.update();
            if (!down && running === 0) {
                var intersects = findIntersections();
                if (intersects.length > 0) {
                    if (INTERSECTED != intersects[ 0 ].object && intersects[ 0 ].object.name !== 'Plane') {
                        if (INTERSECTED) {
                            INTERSECTED.material.color.setHex(INTERSECTED.currentHex);
                        }
                        INTERSECTED = intersects[ 0 ].object;
                        INTERSECTED.currentHex = INTERSECTED.material.color.getHex();
                        INTERSECTED.material.color.setHex(0xffaa55);
                    }
                } else {
                    if (INTERSECTED) {
                        INTERSECTED.material.color.setHex(INTERSECTED.currentHex);
                    }
                    INTERSECTED = null;
                }
            }
        }
    }

    function findIntersections() {
        var vector = new THREE.Vector3(mouse.x, mouse.y, 1);
        projector.unprojectVector(vector, camera);
        var raycaster = new THREE.Raycaster(camera.position, vector.sub(camera.position).normalize());
        return raycaster.intersectObjects(scene.children);
    }

    function onWindowResize(event) {
        renderer.setSize(window.innerWidth, window.innerHeight);

        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();

        camera.lookAt(scene.position);
    }

    var onmessage = function (ev) {
        paused = (ev.data === 'pause');
    };

    function partial(func /*, 0..n args */) {
        var args = Array.prototype.slice.call(arguments, 1);
        return function () {
            var allArguments = args.concat(Array.prototype.slice.call(arguments));
            return func.apply(this, allArguments);
        };
    }

};
