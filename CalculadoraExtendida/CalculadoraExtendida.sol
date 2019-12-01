pragma solidity ^0.5.11; 

contract CalculadoraExtendida {
    
    //Atributos
    struct Memory{
        string _user;
        int256 _memoria;
    }

    mapping (address => Memory) public mapMemory;

    //Evento
    event DivisionPorCero(address from, int256 amount);

    //Constructor
    function Constructor(string memory  _name) public
    {
        Memory memory memo = Memory(_name, 0);
        mapMemory[msg.sender] = memo;
    }
    //Funciones
    function suma(int256 a, int256 b) public pure returns (int256)
    {
        return a + b;
    }
    function sumaMemoria(int256 a) public view returns (int256)
    {
        return a + obtenerMemoria();
    }
    function resta(int256 a, int256 b) public pure returns (int256)
    {
        return a - b;
    }
    function restaMemoria(int256 a) public view returns (int256)
    {
        return a - obtenerMemoria();
    }
    function multiplica(int256 a, int256 b) public pure returns (int256)
    {
        return a * b;
    }
    function multiplicaMemoria(int256 a) public view returns (int256)
    {
        return a * obtenerMemoria();
    }
    function divide(int256 a, int256 b) public pure returns (int256)
    {
        assert(b > 0);
        require(b > 0,"b must be greater than 0");
        return a / b;
    }
    function divideMemoria(int256 a) public returns (int256)
    {
        Memory memory memo = mapMemory[msg.sender];
        if(memo._memoria == 0){
           emit DivisionPorCero(msg.sender, a);
        }
        else{
           return a / memo._memoria;
        }
    }
    function factorial(int256 a) public pure returns (int256)
    {
        assert(a >= 0);
        require(a >= 0,"a must be greater than 0");
        int256 _cont = 1;
        for (int i = a ; i > 0 ; i-- ){
            _cont = _cont*i;
        }
        return _cont;
    }
    function almacenaMemoria(int256 resultado) public returns (int256)
    {
        Memory memory memo = mapMemory[msg.sender];
        memo._memoria = resultado;
        mapMemory[msg.sender] = memo;
        return resultado;
    }
    function obtenerMemoria() public view returns (int256)
    {
        Memory memory memo = mapMemory[msg.sender];
        return memo._memoria;
    }
    function borrarMemoria() public
    {
        Memory memory memo = mapMemory[msg.sender];
        memo._memoria = 0;
        mapMemory[msg.sender] = memo;
    }

}