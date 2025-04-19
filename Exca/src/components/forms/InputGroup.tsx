import { ChangeEvent, useState } from "react"

type Option = {
    label: string
    value: string | number
}

export type PushEvent = {
    target: {
        name: string
        value: string | number
    }
}

type InputGroupProps = {
    id?: string
    name: string
    value: string | number
    type?: 'text' | 'number'
    placeholder: string
    label: string
    options?: Option[]
    onChangeFnc: (e: ChangeEvent<HTMLInputElement> | PushEvent) => void
}

export default function InputGroup({ 
        name, 
        id = name, 
        value, 
        type = 'text', 
        placeholder,
        label,
        onChangeFnc, 
        options = [],
    } : InputGroupProps) 
{
    const [show, setShow] = useState(false)

    const onPushOption = (value: string) => {
        const e : PushEvent = {
            target: {
                name,
                value
            }
        }

        onChangeFnc(e);
    }
    
    return (
        <div className="input-group">
            <label htmlFor={id}>{label}</label>
            <input 
                onFocus={() => setShow(true)}
                onBlur={() => (setTimeout(() => setShow(false), 100))}
                type={type} 
                name={name} 
                id={id} 
                value={value} 
                placeholder={placeholder}
                onChange={onChangeFnc}
            />

            {options.length > 0 && show && (
                <div className="input-options">
                    {options.map(option => (
                        <button type="button" key={option.value} onClick={() => onPushOption(option.label)}>{option.label}</button>
                    ))}
                </div>
            )}
        </div>
    )
}
