let timer;

function startScroll(speed = 2){
    timer = setInterval(() => {
        window.scrollBy(0, speed);
    }, 30)
}

function stopScroll(){
    clearInterval(timer);
}

chrome.runtime.onMessage.addListener((message) => {
    if (message.action == "start") {
        stopScroll(); 
        startScroll(message.speed)
    }

    if (message.action == "stop") stopScroll();

    if (message.action == "changeSpeed"){
        stopScroll();
        startScroll(message.speed);
    }
})