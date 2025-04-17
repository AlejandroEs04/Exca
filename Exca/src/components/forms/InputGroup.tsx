import { ChangeEvent } from "react"

type InputGroupProps = {
    id?: string
    name: string
    value: string | number
    type?: 'text' | 'number'
    placeholder: string
    label: string
    onChangeFnc: (e: ChangeEvent<HTMLInputElement>) => void
}

export default function InputGroup({ 
        name, 
        id = name, 
        value, 
        type = 'text', 
        placeholder,
        label,
        onChangeFnc
    } : InputGroupProps) 
{
    return (
        <div className="input-group">
            <label htmlFor={id}>{label}</label>
            <input 
                type={type} 
                name={name} 
                id={id} 
                value={value} 
                placeholder={placeholder}
                onChange={onChangeFnc}
            />
        </div>
    )
}
