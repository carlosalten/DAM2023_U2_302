<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PilotosRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'nombre'=>'required',
            'numero'=>'required|gte:0',
            'puntos'=>'required|gte:0',
            'fecha_nacimiento'=>'required',
            'pais'=>'required',
        ];
    }

    public function messages():array
    {
        return [
            'nombre.required' => 'Ingrese el nombre del piloto',
            'numero.required' => 'Ingrese el número del auto',
            'numero.gte'=>'Ingrese un número de auto',
            'puntos.required' => 'Ingrese los puntos que lleva',
            'puntos.gte' => 'Ingrese puntaje del piloto',
            'fecha_nacimiento.required' => 'Ingrese fecha de nacimiento',
            'pais.required' => 'Ingrese el país del piloto',
        ];
    }
}
