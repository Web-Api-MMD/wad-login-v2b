const loginDiv = document.querySelector('#logIn');
const logoutDiv = document.querySelector('#logOut');
const userEmail = document.querySelector('#userEmail');
const userPassword = document.querySelector('#userPassword');
const loginBtn = document.querySelector('#loginBtn');
const logoutBtn = document.querySelector('#logoutBtn');
const publicArticle = document.querySelector('#publicArticle');
const privateArticle = document.querySelector('#privateArticle');

const APIaddress = 'http://127.0.0.1:2090';

loginBtn.addEventListener('click', (e) => {
    if(userEmail.value && userPassword.value) {
        const payload = {
            userEmail: userEmail.value,
            userPassword: userPassword.value
        }

        const fetchOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(payload)
        }

        fetch(APIaddress + '/api/accounts/login', fetchOptions)
        .then(response => {
            const token = response.headers.get('x-authenticate-token');
            localStorage.setItem('x-authenticate-token', token); 
            console.log(token);

            return response.json();
        })
        .then(data => {
            console.log(data);
            localStorage.setItem('accountInfo', JSON.stringify(data));
        })

    } else {
        alert('Please enter user email and password');
    }
});