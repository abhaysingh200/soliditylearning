// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// storage- Persistent data location for state variables and function parameters. Changes persist across function calls and transactions.
//memory-- Temporary data location for local variables and function parameters. Values are not persistent and do not persist across function calls.
//calldata -- Used for function parameters to read input data.It is immutable cant change its value.
contract datalocation{

    struct Todo{
        string text;
        bool completed;
    }

    //an array of Todo struct
    Todo[] public todos;

    function create(string calldata _text) public{

        Todo memory todo;
        todo.text= _text;
        todos.push(todo);

        //or
        todos.push( Todo(_text,false));


    } // we need a empyty struct format so we can add new data in our struct.

    //solidity automatically created a getter for 'todos' so
    // you dont actually need this function

    function get(uint _index) public view returns (string memory , bool){

        Todo storage todo = todos[_index];
        return (todo.text,todo.completed);
    }

    //update text
    function updatetext(uint index, string calldata _text) public {
        Todo storage todo =todos[index];
        todo.text=_text;
        //todos[index]= todo;   if we use this using memory then value update the todos struct and if not use then not and you can also see that they user view becuase we are not updating state variable using memory
    }// and if we use storage that means we are pointing the todos at specified index if we change in todo then that will update in todos
    //todo is not a variable created or not copy the todos, its a pointer to access todos
    // and when we use memory instead of storage then, todo will create a new variable and copy all data on his thats why value not update in todos.
   // so when we use storage todo become a element of todos array on that index [10,20] these are elements, and we can update its value
}