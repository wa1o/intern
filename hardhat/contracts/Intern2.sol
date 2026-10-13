// 
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Intern2 {
    enum Estado { Inexistente, Valido, Invalidado }

    struct Registro {
        uint64 fecha;
        Estado estado;
    }

    address public admin;
    mapping(bytes32 => Registro) private registros;

    event DocumentoRegistrado(bytes32 indexed documentoHash, uint64 fecha);
    event DocumentoInvalidado(bytes32 indexed documentoHash);

    modifier soloAdmin() {
        require(msg.sender == admin, "No autorizado");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registrar(bytes32 documentoHash) external soloAdmin {
        require(documentoHash != bytes32(0), "Hash vacio");
        require(registros[documentoHash].estado == Estado.Inexistente, "Ya registrado");

        registros[documentoHash] = Registro(uint64(block.timestamp), Estado.Valido);
        emit DocumentoRegistrado(documentoHash, uint64(block.timestamp));
    }

    function invalidar(bytes32 documentoHash) external soloAdmin {
        require(registros[documentoHash].estado == Estado.Valido, "No esta vigente");
        registros[documentoHash].estado = Estado.Invalidado;
        emit DocumentoInvalidado(documentoHash);
    }

    function verificar(bytes32 documentoHash) external view returns (Estado, uint64 fecha) {
        Registro memory r = registros[documentoHash];
        return (r.estado, r.fecha);
    }
}